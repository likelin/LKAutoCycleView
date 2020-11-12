//
//  NetImageController.m
//  ObjcDemo
//
//  Created by kelin on 2020/11/10.
//

#import "NetImageController.h"
#import "KKAutoCycleScrollView.h"
#import <SDWebImage/SDWebImage.h>

@interface NetImageController ()<KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource>
@property (nonatomic, strong) KKAutoCycleScrollView *cycleView;
@end

@implementation NetImageController

NSArray *netImages() {
    return @[
        @"https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg",
        @"https://icweiliimg6.pstatp.com/weili/l/903360033333313563.jpg",
        @"https://weiliicimg1.pstatp.com/weili/l/812099039242354699.jpg",
        @"https://icweiliimg1.pstatp.com/weili/l/812022923831934995.jpg"
    ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网络图片加载";
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:netImages()[index]]];
    [pageView addSubview:imageView];
}

- (NSInteger)numberOfViewCountInCycleView:(KKAutoCycleScrollView *)cycleView {
    return netImages().count;
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView didClickPageViewAtIndex:(NSInteger)index {
    NSLog(@"current page is %ld", index);
}

- (void)dealloc {
    [_cycleView destory];
}
@end
