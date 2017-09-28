//
//  YelpFilterDataModel.m
//  YelpMock
//
//  Created by Guohua Jiang on 9/12/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "YelpFilterDataModel.h"

@implementation YelpFilterDataModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _categoryCode = dictionary[@"categoryCode"];
        _categoryName = dictionary[@"categoryName"];
    }
    return self;
    
}

+ (NSArray <YelpFilterDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray
{
    NSMutableArray<YelpFilterDataModel *> *dataModelArray = [NSMutableArray new];
    for (NSDictionary *subDict in dictArray) {
        YelpFilterDataModel *dataModel = [[YelpFilterDataModel alloc] initWithDictionary:subDict];
        [dataModelArray addObject:dataModel];
    }
    return [dataModelArray copy];
}

@end
