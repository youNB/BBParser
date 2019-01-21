//
//  ViewController.m
//  parser
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "BBModel.h"
#import "BBParserManager.h"

@implementation BBHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithReuseIdentifier:reuseIdentifier]){
        self.show_des = [[UILabel alloc]init];
        self.show_des.textColor = UIColor.redColor;
        self.show_des.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:self.show_des];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.bounds;
    frame.origin.x = 10;
    frame.size.width -= 20;
    self.show_des.frame = frame;
}

@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *table_view;
@property(nonatomic, strong) BBParserManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItemStyle style = UIBarButtonItemStyleDone;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"转化"
                                                            style:style
                                                           target:self
                                                           action:@selector(clickConvert)];
    self.navigationItem.rightBarButtonItem = item;
    
    CGFloat len = self.view.bounds.size.width;
    CGFloat hei = self.view.bounds.size.height;
    CGFloat top = hei > 800 ? 88 : 64;
    CGRect frame = CGRectMake(0, top, len, hei-top);
    self.table_view = [[UITableView alloc]initWithFrame:frame];
    self.table_view.dataSource = self;
    self.table_view.delegate   = self;
    self.table_view.backgroundColor = UIColor.whiteColor;
    [self.table_view registerClass:UITableViewCell.class
            forCellReuseIdentifier:@"cell"];
    [self.table_view registerClass:BBHeaderView.class
forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:self.table_view];
}

//response
- (void)clickConvert{
    int64_t distance = 24 * 3600 * 7;//一星期
    NSMutableArray *datas = [NSMutableArray array];
    for(NSInteger index = 0; index < 50; index ++){
        NSDictionary *json = @{@"text" : [NSString stringWithFormat:@"第%ld条数据",index+1],
                               @"unix" : @(time(NULL) - distance * index)};
        [datas addObject:json];
    }
    [self.manager parser:datas];
    [self.table_view reloadData];
}

//delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.manager.data_sources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.manager.data_sources[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    NSArray *arr = self.manager.data_sources[indexPath.section];
    BBModel *model = arr[indexPath.row];
    cell.textLabel.text = model.text;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BBHeaderView *header_view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header_view.show_des.text = self.manager.headers[section];
    
    return header_view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{return nil;}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{return 0.0f;}

//lazy load
- (BBParserManager *)manager{
    if(!_manager){
        _manager = [BBParserManager manager:BBModel.class
                                      field:@"month"
                                     header:@"header"];
    }
    return _manager;
}

@end
