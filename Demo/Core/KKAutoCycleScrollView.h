
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KKAutoCycleScrollView;

@protocol KKAutoCycleScrollViewDelegate <NSObject>
@optional
- (void)cycleView:(KKAutoCycleScrollView *)cycleView didClickPageViewAtIndex:(NSInteger)index;
- (void)cycleView:(KKAutoCycleScrollView *)cycleView outerViewScrollingIndex:(NSInteger)index;
@end

@protocol KKAutoCycleScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfViewCountInCycleView:(KKAutoCycleScrollView *)cycleView;
- (void)cycleView:(KKAutoCycleScrollView *)cycleView addSubViewsInPageView:(UIView *)pageView subViewAtIndex:(NSInteger)index;

@end

@interface KKAutoCycleScrollView : UIView

/**
    代理 & 数据源
 */
@property (nonatomic, weak) id<KKAutoCycleScrollViewDelegate>delegate;
@property (nonatomic, weak) id<KKAutoCycleScrollViewDataSource>dataSource;

/**
    是否开启自动循环，默认YES
 */
@property (nonatomic, assign) BOOL autoCycle;


/**
    开启循环的时间间隔,默认4s
 */
@property (nonatomic, assign) NSTimeInterval duration;

- (void)create;
- (void)destory;

/**
    请在 create 执行完之后调用
 */
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
