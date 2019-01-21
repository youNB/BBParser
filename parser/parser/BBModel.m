//
//  BBModel.m
//  parser
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "BBModel.h"

@implementation BBModel

//lazy laod
- (NSDate *)date{
    if(!_date){
        _date = [NSDate dateWithTimeIntervalSince1970:self.unix];
    }
    return _date;
}

- (NSString *)month{
    if(!_month){
        static NSDateFormatter *formatter = nil;
        static dispatch_once_t once_t     = 0;
        dispatch_once(&once_t, ^{
            formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyyMM";
        });
        _month = [formatter stringFromDate:self.date];
    }
    return _month;
}

- (NSString *)header{
    if(!_header){
        static NSDateFormatter *formatter = nil;
        static dispatch_once_t once_t     = 0;
        dispatch_once(&once_t, ^{
            formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"MM月";
        });
        _header = [formatter stringFromDate:self.date];
    }
    return _header;
}

@end
