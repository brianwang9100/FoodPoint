//
//  BuyViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "BuyViewController.h"


@interface BuyViewController ()

@end

@implementation BuyViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self currentLocationIdentifier];
}
-(void) currentLocationIdentifier {
    //---- For getting current gps location
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.myLocationEnabled = YES;
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }
    //------
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error while getting core location : %@",[error localizedFailureReason]);
    if ([error code] == kCLErrorDenied) {
        //you had denied
    }
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%f, %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    marker.title = @"Current Location";
    marker.snippet = @"lilbitchass";
    marker.map = mapView_;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: currentLocation.coordinate.latitude
                                                            longitude: currentLocation.coordinate.longitude
                                                                 zoom:13];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
}


- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
