
#define kAnimateDefaultDuration 0.14f

#import "KKAutoCycleScrollView.h"

@interface KKAutoCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger imageTotalCount;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) NSMutableArray *pageViews;

@property (nonatomic, strong) NSMutableArray *queues;
@end

@implementation KKAutoCycleScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self baseConfig];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseConfig];
    }
    return self;
}

- (void)baseConfig {
    [self setAutoCycle:YES];
    [self setDuration:4];
}

- (void)initContentView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(_imageTotalCount == 1 ? self.frame.size.width : self.frame.size.width * 3, self.frame.size.height);
    scrollView.contentOffset = CGPointMake(_imageTotalCount == 1 ? 0 : self.frame.size.width, 0);
    self.contentView = scrollView;
    [self addSubview:scrollView];
}

- (void)initImagesView {
    NSInteger imageViewCount = _imageTotalCount > 1 ? 3 : 1;
    for (NSInteger i = 0; i < imageViewCount; i++) {
        NSInteger viewIndex = 0;
        if (i == 0) viewIndex = _imageTotalCount - 1;
        if (i == 1) viewIndex = 0;
        if (i == 2) viewIndex = 1;
        
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        pageView.tag = viewIndex;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [pageView addGestureRecognizer:tap];
                
        CGRect frame = pageView.frame;
        [self.dataSource cycleView:self addSubViewsInPageView:pageView subViewAtIndex:pageView.tag];
        pageView.frame = frame;
        
        [self.pageViews addObject:pageView];
        [self.contentView addSubview:pageView];
    }
}

- (void)initMainView {
    [self initContentView];
    [self initImagesView];
}

- (void)create {
    [self destory];
    
    self.imageTotalCount = [self.dataSource numberOfViewCountInCycleView:self];
    if (self.imageTotalCount > 0) {
        [self initMainView];
        [self start];
    }
}

- (void)destory {
    [self stopExcuteLoop];
    [self clear];
}

- (void)clear {
    [self.queues removeAllObjects];
    [self.pageViews removeAllObjects];
    [self.contentView removeFromSuperview];
}

- (void)start {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleView:outerViewScrollingIndex:)]) {
        [self.delegate cycleView:self outerViewScrollingIndex:0];
    }
    if (!self.autoCycle) {
        return;
    }
    [self startExcuteLoop];
}

- (void)startExcuteLoop {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAutoScroll) object:nil];
    [self performSelector:@selector(beginAutoScroll) withObject:nil afterDelay:self.duration];
}

- (void)stopExcuteLoop {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAutoScroll) object:nil];
}

- (void)beginAutoScroll {
    [self setPageContentScrollViewAnimated:YES];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAutoScroll) object:nil];
    [self performSelector:@selector(beginAutoScroll) withObject:nil afterDelay:self.duration];
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    if (self.queues.count == 0) {
        [self scrollToIndex:index duration:[self perPhaseDurationToIndex:index] animated:animated];
    }    
}

- (void)scrollToIndex:(NSInteger)index duration:(NSTimeInterval)duration animated:(BOOL)animated {
    if (_imageTotalCount == 1 ||
        _pageViews.count == 0 ||
        index < 0 ||
        index > _imageTotalCount - 1||
        index == [self currentShowViewIndex]) {
        [self.queues removeAllObjects];
        return;
    }
    [self.queues addObject:NSStringFromSelector(_cmd)];
    CGFloat contentOffsetX = [self ContentOffsetX:index];
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            [self.contentView setContentOffset:CGPointMake(contentOffsetX, 0)];
        } completion:^(BOOL finished) {
            if (finished) {
                [self scrollToIndex:index duration:duration animated:animated];
            }
        }];
    } else {
        [self.contentView setContentOffset:CGPointMake(contentOffsetX, 0)];
        [self scrollToIndex:index duration:duration animated:animated];
    }

}

- (void)setPageContentScrollViewAnimated:(BOOL)animated {
    CGPoint offset = CGPointMake(self.contentView.frame.size.width * 2, 0);
    [self.contentView setContentOffset:offset animated:animated];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoCycle) {
        [self stopExcuteLoop];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoCycle) {
        [self startExcuteLoop];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
     [self reloadImageViewContent];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImageViewContent];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.pageViews.count > 0) {
        [UIView performWithoutAnimation:^{
            CGFloat contentOffsetX = scrollView.contentOffset.x;
            if (contentOffsetX <= 0) { // 向左滑
                [self reloadImageViewContent];
            } else {
                if (contentOffsetX >= self.frame.size.width * 2) {// 向右滑
                    [self reloadImageViewContent];
                }
            }
        }];
    }
}

- (void)reloadImageViewContent {
    if (_imageTotalCount == 1) {return;}
    NSInteger flag = 0;
    CGPoint offset = [self.contentView contentOffset];
    if (offset.x > self.frame.size.width) {
        flag = 1;
    } else if (offset.x <= 0) {
        flag = -1;
    }
    
    for (UIView *imageView in self.pageViews) {
        NSInteger tag = imageView.tag + flag;
        if (tag < 0) {
            tag = _imageTotalCount - 1;
        } else if (tag >= _imageTotalCount) {
            tag = 0;
        }
        
        imageView.tag = tag;
        
        for (UIView *sub in imageView.subviews) {
            [sub removeFromSuperview];
        }
        
        CGRect frame = imageView.frame;
        [self.dataSource cycleView:self addSubViewsInPageView:imageView subViewAtIndex:imageView.tag];
        imageView.frame = frame; // 确保外部不能修改imageView的frame
    }

    UIView *imageView = self.pageViews[1];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleView:outerViewScrollingIndex:)]) {
        [self.delegate cycleView:self outerViewScrollingIndex:imageView.tag];
    }
    self.contentView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

- (void)clickImageView:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleView:didClickPageViewAtIndex:)]) {
        [self.delegate cycleView:self didClickPageViewAtIndex:gesture.view.tag];
    }
}

- (CGFloat)ContentOffsetX:(NSInteger)index {
    NSInteger currentViewIndex = [self currentShowViewIndex];
    CGFloat contentOffsetX = index > currentViewIndex ? self.frame.size.width * 2 : 0;
    return  contentOffsetX;
}

- (NSInteger)currentShowViewIndex {
    if (_imageTotalCount == 1) {return NSNotFound;}
    UIView *currentShowView = self.pageViews[1];
    return currentShowView.tag;
}

- (NSTimeInterval)perPhaseDurationToIndex:(NSInteger)index {
    NSInteger currentViewIndex = [self currentShowViewIndex];
    int totalPhases = abs((int)index - (int)currentViewIndex);
    return kAnimateDefaultDuration / totalPhases;
}

- (BOOL)autoCycle {
    if (_imageTotalCount == 1) {
        return NO;
    }
    return _autoCycle;
}

- (NSMutableArray *)pageViews {
    if (!_pageViews) {
        _pageViews = [NSMutableArray array];
    }
    return _pageViews;
}

- (NSMutableArray *)queues {
    if (!_queues) {
        _queues = [NSMutableArray array];
    }
    return _queues;
}

- (void)dealloc {
    NSLog(@"KKAutoCycleScrollView dealloc");
}

@end
