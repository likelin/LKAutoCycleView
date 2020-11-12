//
//  CustomPageController.m
//  ObjcDemo
//
//  Created by kelin on 2020/11/10.
//

#import "CustomPageController.h"
#import "KKAutoCycleScrollView.h"
#import <SDWebImage/SDWebImage.h>
@interface CustomPageController ()<KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource>
@property (nonatomic, strong) KKAutoCycleScrollView *cycleView;
@end

@implementation CustomPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义每个page";
    [self initCycleView];
}

- (void)initCycleView {
    _cycleView = [[KKAutoCycleScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    _cycleView.delegate = self;
    _cycleView.dataSource = self;
    _cycleView.duration = 4;
    [_cycleView create];
    
    [self.view addSubview:_cycleView];
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView addSubViewsInPageView:(UIView *)pageView subViewAtIndex:(NSInteger)index {

    if (index == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:pageView.bounds];
        imageView.image = [UIImage imageNamed:@"1.png"];
        [pageView addSubview:imageView];
    }
    
    if (index == 1) {
        
        pageView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((pageView.frame.size.width - 200)/2, 30, 200, 60)];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"这这这..是一个label";
        [pageView addSubview:label];
        
        for (NSInteger i = 0; i < 3; i++) {
            CGFloat random1 = (arc4random() % 255) / 255.0;
            CGFloat random2 = (arc4random() % 255) / 255.0;
            CGFloat random3 = (arc4random() % 255) / 255.0;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(20 * (i + 1) + 80 * i, CGRectGetMaxY(label.frame) + 10, 80, 40);
            button.backgroundColor = [UIColor colorWithRed:random1 green:random2 blue:random3 alpha:1.];
            [button setTitle:[NSString stringWithFormat:@"button%ld",i+1] forState:UIControlStateNormal];
            [pageView addSubview:button];
        }
        
    }
    
    if (index == 2) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:pageView.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg"]];
        [pageView addSubview:imageView];
    }
    
}

- (NSInteger)numberOfViewCountInCycleView:(KKAutoCycleScrollView *)cycleView {
    return 3;
}

- (void)cycleView:(KKAutoCycleScrollView *)cycleView didClickPageViewAtIndex:(NSInteger)index {
    NSLog(@"current page is %ld", index);
}

- (void)dealloc {
    [_cycleView destory];
}


@end
