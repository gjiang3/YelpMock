//
//  ViewController.m
//  YelpMock
//
//  Created by Guohua Jiang on 8/26/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "YelpViewController.h"
#import "YelpNetworking.h"
#import "YelpDataModel.h"
#import "YelpTableViewCell.h"
#import "YelpDataStore.h"
#import "DetailYelpViewController.h"
#import "FilterViewController.h"

@import CoreLocation;
@interface YelpViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic, copy) NSArray <YelpDataModel *>*dataModels;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) UIActivityIndicatorView *infiniteLoadingIndicator;
@end

@implementation YelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"YelpTableViewCell"];
    
    CLLocation *loc = [[YelpDataStore sharedInstance] userLocation];
    
    if (!loc) {
        //mock loc
        loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    }

    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:@"restaurant" parameters:[self _generateNetworRelatedParaMeters] completionBlock:^(NSArray<YelpDataModel *> *dataModelArray)
 {
        self.dataModels = dataModelArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSettings)];
    
    //     Setup search bar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = self.searchBar;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(didPullToRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.infiniteLoadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableView.tableFooterView = self.infiniteLoadingIndicator;

}

- (void)didPullToRefresh
{
    CLLocation *loc = [[YelpDataStore sharedInstance] userLocation];
    
    if (!loc) {
        //mock loc
        loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    }
    [self.refreshControl beginRefreshing];
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:@"restaurant" parameters:[self _generateNetworRelatedParaMeters] completionBlock:^(NSArray<YelpDataModel *> *dataModelArray)
 {
        self.dataModels = dataModelArray;
        [self.refreshControl endRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"YelpTableViewCell"];
    
    [cell updateBasedOnDataModel:self.dataModels[indexPath.row]];
    
    if (indexPath.row == [self.dataModels count] - 5) {
        NSMutableDictionary *parameter = [[self _generateNetworRelatedParaMeters] mutableCopy];
        [parameter setObject:[@([self.dataModels count]) stringValue] forKey:@"offset"];
        [self.infiniteLoadingIndicator startAnimating];
        
        CLLocation *loc = [[YelpDataStore sharedInstance] userLocation];
        if (!loc) {
            //mock loc
            loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
        }
        
        [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:self.searchBar.text ?: @"restaurant" parameters:parameter completionBlock:^(NSArray<YelpDataModel *> *dataModelArray)  {
            [self.infiniteLoadingIndicator stopAnimating];
            if ([dataModelArray count]) {
                NSMutableArray *mut = [self.dataModels mutableCopy];
                [mut addObjectsFromArray:dataModelArray];
                self.dataModels = [mut copy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModels count];
}

- (void) didTapSettings
{
    FilterViewController *filterVC = [[FilterViewController alloc] init];
    [self.navigationController pushViewController:filterVC animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailYelpViewController *detailVC = [[DetailYelpViewController alloc] initWithDataModel:self.dataModels[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    
    // the following code the key that we can finally make our table be able to search based on user’s input
    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:@"restaurant" parameters:[self _generateNetworRelatedParaMeters]
                                                     completionBlock:^(NSArray<YelpDataModel *> *dataModelArray)
 {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

// Reset search bar state after cancel button clicked
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}


#pragma mark - Location manager methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    [[YelpDataStore sharedInstance] setUserLocation:currentLocation];
    
    [manager stopUpdatingLocation];
    NSLog(@"current location %lf %lf", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:currentLocation term:@"restaurant" parameters:[self _generateNetworRelatedParaMeters] completionBlock:^(NSArray<YelpDataModel *> *dataModelArray)
 {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

- (NSDictionary<NSString *, NSString *> *)_generateNetworRelatedParaMeters
{
    NSMutableDictionary * dict = [NSMutableDictionary new];
    NSString *categories = @"";
    for (NSString *string in [[YelpDataStore sharedInstance] selectedCategories]) {
        if (categories.length) {
            [categories stringByAppendingString:@","];
            [categories stringByAppendingString:string];
        } else {
            categories = string;
        }
    }
    if ([categories length]) {
        [dict setObject:categories forKey:@"categories"];
    }
    
    if ([[YelpDataStore sharedInstance] priceParameter]) {
        [dict setObject:[[YelpDataStore sharedInstance] priceParameter] forKey:@"price"];
    }
    return [dict copy];
}


@end
