//
//  YelpDataModel.h
//  YelpMock
//
//  Created by Guohua Jiang on 8/26/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YelpDataModel : NSObject
@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) UIImage *ratingImage;
@property (nonatomic, strong) NSString *displayPhone;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *displayAddress;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray <YelpDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray;
@end

