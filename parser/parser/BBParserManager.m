//
//  BBParserManager.m
//  parser
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "BBParserManager.h"
#import <objc/runtime.h>

@interface BBParserManager ()
@property(nonatomic, assign) Class modelClass;
@property(nonatomic, strong) NSString *field;
@property(nonatomic, strong) NSString *header;
@property(nonatomic, strong) NSString *last_field;
@end

@implementation BBParserManager

+ (BBParserManager *)manager:(Class)model
                       field:(NSString *)field
                      header:(NSString *)header{
    NSAssert(model,  @"请输入类类型");
    NSAssert(field,  @"请输入分块标识");
    NSAssert(header, @"请输入头标识");
    BBParserManager *manager = [[self alloc]init];
    manager.modelClass = model;
    manager.field  = field;
    manager.header = header;
    
    return manager;
}

- (void)parser:(NSArray *)datas{
    BOOL state = [datas isKindOfClass:NSArray.class];
    if(!state || !datas.count){return;}//传进来的数据类型不对/没有数据
    
    NSMutableArray *result = self.data_sources.lastObject;
    for(NSDictionary *d in datas){
        if(![d isKindOfClass:[NSDictionary class]]){continue;}
        id obj = [[self.modelClass alloc]init];
        [obj setValuesForKeysWithDictionary:d];
        NSString *value = [obj valueForKey:self.field];
        if(!value){continue;}
        _count ++;
        if(!result){goto XZContainerManager_MARK;}

        if([self.last_field isEqualToString:value]){[result addObject:obj];}
        else{
XZContainerManager_MARK:
            self.last_field = value;
            result = [NSMutableArray array];
            [self.data_sources addObject:result];
            NSString *header = [[obj valueForKey:self.header] description];
            [self.headers addObject:header ? header : @""];
            [result addObject:obj];
        }
    }
}

- (void)clear{
    _data_sources = nil;
    _headers = nil;
    _count   = 0;
}

//lazy load
@synthesize data_sources = _data_sources;
@synthesize headers = _headers;
- (NSMutableArray<NSMutableArray *> *)data_sources{
    if(!_data_sources){
        _data_sources = [NSMutableArray array];
    }
    return _data_sources;
}

- (NSMutableArray<NSString *> *)headers{
    if(!_headers){
        _headers = [NSMutableArray array];
    }
    return _headers;
}

@end
