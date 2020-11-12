//
//  ComplexPageController.m
//  ObjcDemo
//
//  Created by kelin on 2020/11/10.
//

#import "ComplexPageController.h"
#import "KKAutoCycleScrollView.h"
#import <SDWebImage/SDWebImage.h>

@interface ComplexPageController ()<KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource>
@property (nonatomic, strong) KKAutoCycleScrollView *cycleView1;
@property (nonatomic, strong) KKAutoCycleScrollView *cycleView2;
@property (nonatomic, strong) UIPageControl *pageControl1;
@property (nonatomic, strong) UIPageControl *pageControl2;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ComplexPageController

NSArray *cycle1Datas() {
    return @[
        @{@"image":@"1.png", @"title":@"这是第一张图片"},
        @{@"image":@"2.png", @"title":@"这是第二张图片"},
        @{@"image":@"3.png", @"title":@"这是第三张图片"},
        @{@"image":@"4.png", @"title":@"这是第四张图片"},
    ];
}

NSArray *cycle2Datas() {
    return @[
        @{@"image":@"https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg", @"title":@"第一张网络图片【草原】"},
        @{@"image":@"https://icweiliimg6.pstatp.com/weili/l/903360033333313563.jpg", @"title":@"第二张网络图片【公路】"},
        @{@"image":@"https://weiliicimg1.pstatp.com/weili/l/812099039242354699.jpg", @"title":@"第三张网络图片【灯笼】"},
        @{@"image":@"https://icweiliimg1.pstatp.com/weili/l/812022923831934995.jpg", @"title":@"第四张网络图片【雪山】"},
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"复杂轮播图";
    [self initCycleView1];
    [self initCycleView2];
    
    [self.cycleView1 scrollToIndex:1 animated:NO];
}

- (void)initCycleView1 {
    _cycleView1 = [[KKAutoCycleScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    _cycleView1.delegate = self;
    _cycleView1.dataSource = self;
    _cycleView1.autoCycle = NO;
    
    [_cycleView1 create];
    
    _pageControl1 = [[UIPageControl alloc] initWithFrame:CGRectMake((_cycleView1.frame.size.width - 200)/2, CGRectGetMaxY(_cycleView1.frame)- 40, 200, 50)];
    _pageControl1.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl1.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageControl1.numberOfPages = cycle1Datas().count;
    [_pageControl1 addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 14.0, *)) {
        _pageControl1.allowsContinuousInteraction = YES;
    }
    
    [self.view addSubview:_cycleView1];
    [self.view addSubview:_pageControl1];
}

- (void)initCycleView2 {
    _cycleView2 = [[KKAutoCycleScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleView1.frame) + 30, self.view.frame.size.width, 200)];
    _cycleView2.delegate = self;
    _cycleView2.dataSource = self;
    _cycleView2.duration = 2;
    _cycleView2.autoCycle = YES;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleView2.frame)- 40, _cycleView2.frame.size.width, 40)];
    _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _titleLabel.textColor = [UIColor whiteColor];
    
    _pageControl2 = [[UIPageControl alloc] initWithFrame:CGRectMake(_cycleView2.frame.size.width - 150, CGRectGetMaxY(_cycleView2.frame)- 40, 200, 40)];
    _pageControl2.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl2.userInteractionEnabled = NO;
    _pageControl2.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageControl2.numberOfPages = cycle2Datas().count;
    
    [self.view addSubview:_cycleView2];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_pageControl2];
    
    [_cycleView2 create];

}

- (void)pageChange:(UIPageControl *)pageControl {
    if ([self pageControlCanContinuousInteraction:pageControl]) {
        [self.cycleView1 scrollToIndex:pageControl.currentPage animated:NO];
    } else {
        [self.cycleView1 scrollToIndex:pageControl.currentPage animated:YES];
    }
}

- (BOOL)pageControlCanContinuousInteraction:(UIPageControl *)pageControl {
    if (@available(iOS 14.0, *)) {
        if (!pageControl.allowsContinuousInteraction) {
            return NO;
        }
        NSArray *gestures = [pageControl gestureRecognizers];
        for (UIGestureRecognizer *gesture in gestures) {
            if (gesture.state == UIGestureRecognizerStateFailed ||
                gesture.state == UIGestureRecognizerStateEnded) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}


- (void)cycleView:(KKAutoCycleScrollView *)cycleView addSubViewsInPageView:(UIView *)pageView subViewAtIndex:(NSInteger)index {
    
    if (cycleView == self.cycleView1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:pageView.bounds];
        imageView.image = [UIImage imageNamed:cycle1Datas()[index][@"image"]];
        [pageView addSubview:imageView];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, pageView.frame.size.height - 40, pageView.frame.size.width, 40)];
        descLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        descLabel.text = cycle1Datas()[index][@"title"];
        descLabel.textColor = [UIColor whiteColor];
        [pageView addSubview:descLabel];
    }
    
    
    if (cycleView == self.cycleView2) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:pageView.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:cycle2Datas()[index][@"image"]]];
        [pageView addSubview:imageView];
    }
    

}

- (NSInteger)numberOfViewCountInCycleView:(KKAutoCycleScrollView *)cycleView {
    if (cycleView == self.cycleView1) {
        return cycle1Datas().count;
    }
    if (cycleView == self.cycleView2) {
        return cycle2Datas().count;
    }
    return 0;
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView didClickPageViewAtIndex:(NSInteger)index {
    NSLog(@"current page is %ld", index);
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView outerViewScrollingIndex:(NSInteger)index {
    if (cycleView == self.cycleView1) {
        self.pageControl1.currentPage = index;
    }
    
    if (cycleView == self.cycleView2) {
        self.titleLabel.text = cycle2Datas()[index][@"title"];
        self.pageControl2.currentPage = index;
    }
}

- (void)dealloc {
    [_cycleView1 destory];
    [_cycleView2 destory];
}



@end
