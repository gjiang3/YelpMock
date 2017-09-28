//
//  YelpDataStore.m
//  YelpMock
//
//  Created by Guohua Jiang on 9/2/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "YelpDataStore.h"
@implementation YelpDataStore

- (instancetype)init
{
    if (self = [super init]){
        self.selectedCategories = [NSMutableSet new];
    }
    return self;
}


+ (YelpDataStore *)sharedInstance {
    static YelpDataStore *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[YelpDataStore alloc] init];
    });
    return _sharedInstance;
}
@end
