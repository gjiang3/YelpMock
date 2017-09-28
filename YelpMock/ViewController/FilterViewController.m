//
//  FilterViewController.m
//  YelpMock
//
//  Created by Guohua Jiang on 9/12/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterTableViewCell.h"
#import "PriceTableViewCell.h"
#import "YelpFilterDataModel.h"

typedef NS_ENUM(NSInteger, FilterViewSection) {
    FilterViewSectionPrice = 0,
    FilterViewSectionCategory
};

@interface FilterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<YelpFilterDataModel *> *categories;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCatogries];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterTableViewCell" bundle:nil] forCellReuseIdentifier:@"FilterTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PriceTableViewCell" bundle:nil] forCellReuseIdentifier:@"PriceTableViewCell"];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == FilterViewSectionPrice) {
        return 1;
    } else if (section == FilterViewSectionCategory) {
        return [self.categories count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == FilterViewSectionPrice) {
        PriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceTableViewCell"];
        return cell;
    } else if (indexPath.section == FilterViewSectionCategory) {
        FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
        [cell updateDataModel:self.categories[indexPath.row]];
        return cell;
    } else {
        return nil;
    }
}

- (void)setupCatogries
{
    NSArray <NSDictionary *> *categories =  @[@{@"categoryName" : @"American, New", @"categoryCode": @"newamerican" },
                                              @{@"categoryName" : @"American, Traditional", @"categoryCode": @"tradamerican" },
                                              @{@"categoryName" : @"Asian Fusion", @"categoryCode": @"asianfusion" },
                                              @{@"categoryName" : @"Australian", @"categoryCode": @"australian" },
                                              @{@"categoryName" : @"Brazilian", @"categoryCode": @"brazilian" },
                                              @{@"categoryName" : @"Breakfast & Brunch", @"categoryCode": @"breakfast_brunch" },
                                              @{@"categoryName" : @"British", @"categoryCode": @"british" },
                                              @{@"categoryName" : @"Cafes", @"categoryCode": @"cafes" },
                                              @{@"categoryName" : @"Cafeteria", @"categoryCode": @"cafeteria" },
                                              @{@"categoryName" : @"Cajun/Creole", @"categoryCode": @"cajun" },
                                              @{@"categoryName" : @"Caribbean", @"categoryCode": @"caribbean" },
                                              @{@"categoryName" : @"Catalan", @"categoryCode": @"catalan" },
                                              @{@"categoryName" : @"Chicken Wings", @"categoryCode": @"chicken_wings" },
                                              @{@"categoryName" : @"Chinese", @"categoryCode": @"chinese" },
                                              @{@"categoryName" : @"Dumplings", @"categoryCode": @"dumplings" },
                                              @{@"categoryName" : @"Eastern European", @"categoryCode": @"eastern_european" },
                                              @{@"categoryName" : @"Fast Food", @"categoryCode": @"hotdogs" },
                                              @{@"categoryName" : @"Fish & Chips", @"categoryCode": @"fishnchips" },
                                              @{@"categoryName" : @"Food Court", @"categoryCode": @"food_court" },
                                              @{@"categoryName" : @"French", @"categoryCode": @"french" },
                                              @{@"categoryName" : @"French Southwest", @"categoryCode": @"sud_ouest" },
                                              @{@"categoryName" : @"German", @"categoryCode": @"german" },
                                              @{@"categoryName" : @"Gluten-Free", @"categoryCode": @"gluten_free" },
                                              @{@"categoryName" : @"Greek", @"categoryCode": @"greek" },
                                              @{@"categoryName" : @"Hawaiian", @"categoryCode": @"hawaiian" },
                                              @{@"categoryName" : @"Hong Kong Style Cafe", @"categoryCode": @"hkcafe" },
                                              @{@"categoryName" : @"Hot Dogs", @"categoryCode": @"hotdog" },
                                              @{@"categoryName" : @"Hot Pot", @"categoryCode": @"hotpot" },
                                              @{@"categoryName" : @"Indian", @"categoryCode": @"indpak" },
                                              @{@"categoryName" : @"Indonesian", @"categoryCode": @"indonesian" },
                                              @{@"categoryName" : @"International", @"categoryCode": @"international" },
                                              @{@"categoryName" : @"Island Pub", @"categoryCode": @"island_pub" },
                                              @{@"categoryName" : @"Israeli", @"categoryCode": @"israeli" },
                                              @{@"categoryName" : @"Italian", @"categoryCode": @"italian" },
                                              @{@"categoryName" : @"Japanese", @"categoryCode": @"japanese" },
                                              @{@"categoryName" : @"Korean", @"categoryCode": @"korean" },
                                              @{@"categoryName" : @"Latin American", @"categoryCode": @"latin" },
                                              @{@"categoryName" : @"Lyonnais", @"categoryCode": @"lyonnais" },
                                              @{@"categoryName" : @"Malaysian", @"categoryCode": @"malaysian" },
                                              @{@"categoryName" : @"Mexican", @"categoryCode": @"mexican" },
                                              @{@"categoryName" : @"New Zealand", @"categoryCode": @"newzealand" },
                                              @{@"categoryName" : @"Night Food", @"categoryCode": @"nightfood" },
                                              @{@"categoryName" : @"Norcinerie", @"categoryCode": @"norcinerie" },
                                              @{@"categoryName" : @"Open Sandwiches", @"categoryCode": @"opensandwiches" },
                                              @{@"categoryName" : @"Oriental", @"categoryCode": @"oriental" },
                                              @{@"categoryName" : @"Pakistani", @"categoryCode": @"pakistani" },
                                              @{@"categoryName" : @"Parent Cafes", @"categoryCode": @"eltern_cafes" },
                                              @{@"categoryName" : @"Persian/Iranian", @"categoryCode": @"persian" },
                                              @{@"categoryName" : @"Pizza", @"categoryCode": @"pizza" },
                                              @{@"categoryName" : @"Polish", @"categoryCode": @"polish" },
                                              @{@"categoryName" : @"Portuguese", @"categoryCode": @"portuguese" },
                                              @{@"categoryName" : @"Potatoes", @"categoryCode": @"potatoes" },
                                              @{@"categoryName" : @"Rice", @"categoryCode": @"riceshop" },
                                              @{@"categoryName" : @"Russian", @"categoryCode": @"russian" },
                                              @{@"categoryName" : @"Sandwiches", @"categoryCode": @"sandwiches" },
                                              @{@"categoryName" : @"Scandinavian", @"categoryCode": @"scandinavian" },
                                              @{@"categoryName" : @"Seafood", @"categoryCode": @"seafood" },
                                              @{@"categoryName" : @"Soup", @"categoryCode": @"soup" },
                                              @{@"categoryName" : @"Sushi Bars", @"categoryCode": @"sushi" },
                                              @{@"categoryName" : @"Swedish", @"categoryCode": @"swedish" },
                                              @{@"categoryName" : @"Taiwanese", @"categoryCode": @"taiwanese" },
                                              @{@"categoryName" : @"Thai", @"categoryCode": @"thai" },
                                              @{@"categoryName" : @"Vegan", @"categoryCode": @"vegan" },
                                              @{@"categoryName" : @"Wraps", @"categoryCode": @"wraps" }];
    
    self.categories = [YelpFilterDataModel buildDataModelArrayFromDictionaryArray:categories];
    
}

@end
