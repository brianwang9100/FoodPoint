//
//  SellViewController.m
//  FoodPoint
//
//  Created by Diva Hurtado on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "SellViewController.h"

@interface SellViewController ()

@end

@implementation SellViewController {
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
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.distanceFilter = kCLDistanceFilterNone;
            _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
        }
        [_locationManager startUpdatingLocation];
    }
    //------
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: _locationManager.location.coordinate.latitude
                                                            longitude: _locationManager.location.coordinate.longitude
                                                                 zoom:13];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.myLocationEnabled = YES;
    
    [_locationManager stopUpdatingLocation];
    
    NSString *baseURL = @"https://shining-heat-3529.firebaseio.com/";
    
    Firebase *rootRef = [[Firebase alloc] initWithUrl:baseURL];
    Firebase *buyersRef = [rootRef childByAppendingPath: @"buyers"];
    Firebase *marketsRef = [rootRef childByAppendingPath: @"markets"];
    
//    //sending buyer information
//    NSDictionary *buyer = @{
//                            @"lat": [NSString stringWithFormat: @"%f", _locationManager.location.coordinate.latitude],
//                            @"lon": [NSString stringWithFormat:@"%f", _locationManager.location.coordinate.longitude],
//                            @"email": _thisSeller.email,
//                            @"trans": [NSString stringWithFormat: @"%d", _thisBuyer.trans ]
//                            };
//    
//    Firebase *newBuyerRef = [buyersRef childByAppendingPath: _thisBuyer.name];
//    [newBuyerRef setValue: buyer];
    
    //retreiving market information
    [[buyersRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        CGPoint point = [self convertToLocation: snapshot];
        NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        if ([snapshot.value[@"trans"]integerValue] == 1) {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        } else {
            marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
        }
        marker.position = CLLocationCoordinate2DMake(point.x, point.y);
        marker.title = snapshot.key;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        if ([snapshot.value[@"trans"]integerValue] == 1) {
        }
        //marker.snippet = [NSString stringWithFormat:@"%d sellers", snapshot.childrenCount[@"sellers"]];
        marker.map = mapView_;
    }];
    
    [[marketsRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        CGPoint point = [self convertToLocation: snapshot];
        NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
        marker.position = CLLocationCoordinate2DMake(point.x, point.y);
        marker.title = snapshot.key;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.snippet = [NSString stringWithFormat:@"%d sellers and %d buyers", [snapshot.value[@"sellers"] count],[snapshot.value[@"buyers"] count]];
        marker.map = mapView_;
    }];
    
    self.view = mapView_;
    
}

- (CGPoint) convertToLocation:(FDataSnapshot*) snap {
    NSString *lat = snap.value[@"lat"];
    NSString *lon = snap.value[@"lon"];
    CGPoint point = CGPointFromString([NSString stringWithFormat:@"{%@,%@}",lat, lon]);
    return point;
}

//- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"%f, %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
//
////    CLLocation *currentLocation = [locations objectAtIndex:0];
////    GMSMarker *marker = [[GMSMarker alloc] init];
////    marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
////    marker.title = @"Current Location";
////    marker.snippet = @"lilbitchass";
////    marker.map = mapView_;
//
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: locationManager.location.coordinate.latitude
//                                                            longitude: locationManager.location.coordinate.longitude
//                                                                 zoom:13];
//    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    mapView_.delegate = self;
//    self.view = mapView_;
//    [_locationManager stopUpdatingLocation];
//}
//

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //    [mapView_ removeObserver:self
    //                  forKeyPath:@"myLocation"
    //                     context:NULL];
}

@end
