//
//  BuyViewController.h
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "Buyer.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface BuyViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) Buyer *thisBuyer;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstTimeUse;


@end
