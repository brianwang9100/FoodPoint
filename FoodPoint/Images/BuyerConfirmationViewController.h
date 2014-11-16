//
//  BuyerConfirmationViewController.h
//  FoodPoint
//
//  Created by Brian Wang on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Seller.h"
#import "Buyer.h"

@interface BuyerConfirmationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameOfMarketLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *nameOfMarket;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (assign, nonatomic) BOOL sent;
@property (strong, nonatomic) Buyer* thisBuyer;
@property (strong, nonatomic) NSString *marketHashCode;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@end
