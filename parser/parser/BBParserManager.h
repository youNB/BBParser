//
//  BBParserManager.h
//  parser
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRIORITY @"未完成"

@interface BBParserManager : NSObject
@property(nonatomic, strong, readonly) NSMutableArray<NSMutableArray *> *data_sources;
@property(nonatomic, strong, readonly) NSMutableArray<NSString *> *headers;
@property(nonatomic, assign, readonly) NSInteger count;//数据的个数

/*
 data_sources:对外展示的数据源
 headers:对外展示的头
 
 model:你的数据模型
 field:按照上面模型里面的那个字段进行分块;
       例如如果是按月份分块，那么这里就是model里面的月份那个字段
 header:将要放在header里面的值,tableView/collectionView的headerView上展示的字段名
 PRIORITY:特殊划分下的头
*/
+ (BBParserManager *)manager:(Class)model
                       field:(NSString *)field
                      header:(NSString *)header;

- (void)parser:(NSArray *)datas;

- (void)clear;

@end

