//
//  KKMainViewController.m
//  Demo
//
//  Created by kelin on 2020/11/10.
//

#import "KKMainViewController.h"

@interface KKMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KKMainViewController

NSArray * datas() {
    return @[
        @{@"text":@"本地图片",@"vc":@"LocalImageController"},
        @{@"text":@"网络图片",@"vc":@"NetImageController"},
        @{@"text":@"自定义每个page的样式",@"vc":@"CustomPageController"},
        @{@"text":@"复杂用法",@"vc":@"ComplexPageController"}
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}

- (void)initViews {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas().count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = datas()[indexPath.row][@"text"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *vcName = datas()[indexPath.row][@"vc"];
    [self.navigationController pushViewController:NSClassFromString(vcName).new animated:YES];
}

@end
