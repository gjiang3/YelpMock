//
//  MapViewController.m
//  YelpMock
//
//  Created by Guohua Jiang on 9/2/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "MapViewController.h"
#import "YelpDataStore.h"
#import "YelpAnnotation.h"
#import <UIImageView+AFNetworking.h>
@import MapKit;
#import "DetailYelpViewController.h"


@interface MapViewController () <MKMapViewDelegate>
@property (nonatomic) MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.mapView];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;
    location.latitude = 37.331566;
    location.longitude = -122.032744;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setCenterCoordinate:location animated:YES];
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateAnnotation];
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
    if ([[YelpDataStore sharedInstance] userLocation]) {
        [self.mapView setCenterCoordinate:[[YelpDataStore sharedInstance] userLocation].coordinate animated:YES];
    }
    
    self.navigationItem.title = @"Map";
}

- (void)updateAnnotation
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    NSArray <YelpAnnotation *> *annotations = [YelpAnnotation buildAnnotationArrayFromDataArray:[[YelpDataStore sharedInstance] dataModels]];
    [self.mapView addAnnotations:annotations];
}

#pragma mark - Map methods
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    YelpAnnotation *annotation = view.annotation;
    DetailYelpViewController *detailVC = [[DetailYelpViewController alloc] initWithDataModel:annotation.dataModel];
//    [self.navigationController pushViewController:detailVC animated:YES];
    [self presentViewController:detailVC animated:YES completion:nil];
}

// Show customized callout for each business annotation
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // If the annotation is the user location, just return nil.
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        return;
    }
    
    // Add a custom image to the left side of the callout.
    YelpAnnotation *annotation = view.annotation;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [imageView setImageWithURL:[NSURL URLWithString:annotation.dataModel.imageUrl]];
    view.leftCalloutAccessoryView = imageView;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}

@end
