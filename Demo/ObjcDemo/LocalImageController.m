//
//  LocalImageController.m
//  ObjcDemo
//
//  Created by kelin on 2020/11/10.
//

#import "LocalImageController.h"
#import "KKAutoCycleScrollView.h"

@interface LocalImageController ()<KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource>
@property (nonatomic, strong) KKAutoCycleScrollView *cycleView;
@end

@implementation LocalImageController

NSArray *localImages() {
    return @[
        @"1.png",
        @"2.png",
        @"3.png",
        @"4.png"
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本地图片加载";
    [self initCycleView];
}

- (void)initCycleView {
    _cycleView = [[KKAutoCycleScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    _cycleView.delegate = self;
    _cycleView.dataSource = self;
    _cycleView.duration = 2;
    [_cycleView create];
    
    [self.view addSubview:_cycleView];
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView addSubViewsInPageView:(UIView *)pageView subViewAtIndex:(NSInteger)index {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:pageView.bounds];
    imageView.image = [UIImage imageNamed:localImages()[index]];
    [pageView addSubview:imageView];
}

- (NSInteger)numberOfViewCountInCycleView:(KKAutoCycleScrollView *)cycleView {
    return localImages().count;
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView didClickPageViewAtIndex:(NSInteger)index {
    NSLog(@"current page is %ld", index);
}

- (void)dealloc {
    [_cycleView destory];
}

@end
