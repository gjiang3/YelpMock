//
//  YelpNetworking.h
//  YelpMock
//
//  Created by Guohua Jiang on 8/26/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpDataModel.h"

@import CoreLocation;

typedef void (^RestaurantCompletionBlock)(NSArray <YelpDataModel *>* dataModelArray);

@interface YelpNetworking : NSObject

+ (YelpNetworking *)sharedInstance;

- (void)fetchRestaurantsBasedOnLocation:(CLLocation *)location term:(NSString *)term parameters:(NSDictionary *)parameters completionBlock:(RestaurantCompletionBlock)completionBlock;

@end
