//
//  MapTableViewCell.h
//  YelpMock
//
//  Created by Guohua Jiang on 9/5/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"


@interface MapTableViewCell : UITableViewCell

- (void)updateBasedOnDataModel:(YelpDataModel *)dataModel;
@end
