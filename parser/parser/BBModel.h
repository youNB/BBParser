//
//  BBModel.h
//  parser
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBModel : NSObject
@property(nonatomic, strong) NSString *text;
@property(nonatomic, assign) int64_t  unix;

//自定义
@property(nonatomic, strong) NSDate   *date;
@property(nonatomic, strong) NSString *month;
@property(nonatomic, strong) NSString *header;
@end
