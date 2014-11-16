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
//    _thisBuyer = [[Buyer alloc] initWithName:@"BitchAss" withEmail: @"bitchass@gmail.com" withTrans:true];
    
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
                                                                 zoom:12];
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
    
    //sending buyer information
    NSDictionary *buyer = @{
                            @"lat": [NSString stringWithFormat: @"%f", _locationManager.location.coordinate.latitude],
                            @"lon": [NSString stringWithFormat:@"%f", _locationManager.location.coordinate.longitude],
                            @"email": (NSString*)_thisBuyer.email,
                            @"trans": [NSString stringWithFormat: @"%d", _thisBuyer.trans ]
                            };
    
    Firebase *newBuyerRef = [buyersRef childByAppendingPath: _thisBuyer.name];
    [newBuyerRef setValue: buyer];
    
    //retreiving market information
    [[marketsRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        CGPoint point = [self convertToLocation: snapshot];
        NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.icon = [GMSMarker markerImageWithColor: [UIColor blueColor]];
        marker.position = CLLocationCoordinate2DMake(point.x, point.y);
        marker.title = @"Selected Market";
        marker.appearAnimation = kGMSMarkerAnimationPop;
//        marker.snippet = [NSString stringWithFormat:@"%d sellers", snapshot.childrenCount[@"sellers"]];
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
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
//    marker.title = @"Current Location";
//    marker.snippet = @"lilbitchass";
//    marker.map = mapView_;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
