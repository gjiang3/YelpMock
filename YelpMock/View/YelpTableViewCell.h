//
//  YelpTableViewCell.h
//  YelpMock
//
//  Created by Guohua Jiang on 8/29/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface YelpTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;

@end

