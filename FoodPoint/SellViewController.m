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
    GMSMarker* _somemarker;
    GMSMarker *_selectedMarker;
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
            UIImage *driver = [UIImage imageNamed:@"icon-blue.png"];
            driver = [self resizeImage:driver];
            marker.icon = driver;
        } else {
            UIImage *walker = [UIImage imageNamed:@"icon-green.png"];
            walker = [self resizeImage:walker];
            marker.icon = walker;
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
        marker.title = @"Durham Farmer's Market";
        marker.snippet = [NSString stringWithFormat:@"segue %@", snapshot.key];
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
    _somemarker.map = nil;
    _somemarker = [[GMSMarker alloc] init];
    _somemarker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
    _somemarker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    _somemarker.title = @"Place a market here?";
    _somemarker.map = mapView;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_somemarker.position.latitude longitude:_somemarker.position.longitude zoom:12];
    
    GMSCameraUpdate *panCam = [GMSCameraUpdate setTarget:CLLocationCoordinate2DMake(_somemarker.position.latitude,_somemarker.position.longitude)];
    [mapView_ animateWithCameraUpdate:panCam];
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



//- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
////    InfoWindow *view =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
////    view.name.text = @"Place Name";
////    view.description.text = @"Place description";
////    view.phone.text = @"123 456 789";
////    view.placeImage.image = [UIImage imageNamed:@"customPlaceImage"];
////    view.placeImage.transform = CGAffineTransformMakeRotation(-.08);
////    return view;
//    int popupWidth = 250;
//    int popupHeight = 50;
//    int contentPad = 7;
//    int contentWidth = 240;
//
//    CLLocationCoordinate2D anchor = marker.position;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, popupHeight)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentPad, 0, contentWidth, 50)];
//    [titleLabel setFont:[UIFont systemFontOfSize:15.0]];
//    titleLabel.text = [marker title];
//    
//    [view addSubview:titleLabel];
//    
//    return view;
//    
//}


-(void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    _selectedMarker = marker;
//    if ([marker.snippet containsString: @"segue"]) {
    [self performSegueWithIdentifier:@"segue" sender:self];
//
//    }
}

//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if([segue.identifier isEqualToString:@"segue"]) {
//        ConfirmationViewController *controller = (ConfirmationViewController*) segue.destinationViewController;
//        controller.thisSeller = _thisSeller;
//        controller.nameOfMarket = _selectedMarker.title;
//        controller.marketHashCode = [_selectedMarker.snippet stringByReplacingOccurrencesOfString:@"segue " withString:@""];
//        
//    }
//}

-(UIImage*)resizeImage: (UIImage*) image {
    CGRect rect = CGRectMake(0,0,25,50);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    return [UIImage imageWithData:imageData];
}



@end
