//
//  YelpFilterDataModel.h
//  YelpMock
//
//  Created by Guohua Jiang on 9/12/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpFilterDataModel : NSObject

@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *categoryCode;

+ (NSArray <YelpFilterDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray;

@end
