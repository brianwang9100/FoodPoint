//
//  SellViewController.h
//  FoodPoint
//
//  Created by Diva Hurtado on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "Seller.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ConfirmationViewController.h"

@interface SellViewController : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate>
@property (strong, nonatomic) Seller *thisSeller;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstTimeUse;

@end
