//
//  FilterTableViewCell.h
//  YelpMock
//
//  Created by Guohua Jiang on 9/12/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpFilterDataModel.h"

@interface FilterTableViewCell : UITableViewCell

- (void)updateDataModel:(YelpFilterDataModel *)dataModel;

@end
