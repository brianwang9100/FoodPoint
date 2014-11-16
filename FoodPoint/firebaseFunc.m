//
//  firebaseFunc.m
//  FoodPoint
//
//  Created by Diva Hurtado on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>





NSString *baseURL = @"https://shining-heat-3529.firebaseio.com/";

Firebase *rootRef = [[Firebase alloc] initWithUrl:baseURL];
Firebase *buyersRef = [rootRef childByAppendingPath: @"buyers"];
Firebase *marketsRef = [rootRef childByAppendingPath: @"markets"];

Firebase *samsRef = [buyersRef childByAppendingPath:@"Samantha"];
// use to read data once
[samsRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
    NSLog([NSString stringWithFormat:@"%@", snapshot.key]);
    NSLog([NSString stringWithFormat:@"%@", snapshot.value]);
    NSLog([NSString stringWithFormat:@"%@", snapshot.value[@"lat"]]);
    //2014-11-15 22:36:33.791 FoodPoint[19894:15635194] Samantha
    //2014-11-15 22:36:33.791 FoodPoint[19894:15635194] {
    //    lat = 1;
    //    lon = 3;
    //    trans = 1;
    //}
    //2014-11-15 22:36:33.791 FoodPoint[19894:15635194] 1
}];


/* loop through children first and then have a callback for when new ones are added */

[[buyersRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
    CGPoint point = [self convertToLocation: snapshot];
    NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
    //2014-11-16 00:36:56.127 FoodPoint[20767:15745955] 34.540000, 45.345323
    //2014-11-16 00:36:56.127 FoodPoint[20767:15745955] 1.000000, 3.000000
}];


[[marketsRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
    CGPoint point = [self convertToLocation: snapshot];
    NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
    //2014-11-15 22:36:33.833 FoodPoint[19894:15635194] 49.753450, 302.345454
    //2014-11-15 22:36:33.834 FoodPoint[19894:15635194] -49.000000, 203.000000
    //2014-11-15 22:36:33.834 FoodPoint[19894:15635194] 3.000000, 35.000000
}];


/*
 // set a buyer in firebase
 NSString *trans = @"walk";  // or @"car"
 
 NSDictionary *buyer = @{
 @"lat": @34.54,
 @"lon": @45.345323,
 @"trans": trans
 };
 
 Firebase *newBuyerRef = [buyersRef childByAutoId];
 [newBuyerRef setValue: buyer];
 */


// set a market
NSString *date = @"11/5/2014";
NSString *name = @"Rob";
NSString *name2 = @"Timmy";

NSDictionary *sellers = @{
                          name: @{
                                  @"email": @"rob@wat.io"
                                  },
                          name2: @{
                                  @"email": @"rob@hello.com"
                                  }
                          };

NSDictionary *marketInfo = @{
                             @"date": date,
                             @"lat": @34.54,
                             @"lon": @45.345323,
                             @"sellers": sellers
                             };

// either set string of market here
Firebase *newMarketRef = [marketsRef childByAppendingPath: @"hash markeet"];

/* or randomly generate
 Firebase *newMarketRef = [marketsRef childByAutoId];
 */

[newMarketRef setValue: marketInfo];

}

- (CGPoint) convertToLocation:(FDataSnapshot*) snap {
    NSString *lat = snap.value[@"lat"];
    NSString *lon = snap.value[@"lon"];
    CGPoint point = CGPointFromString([NSString stringWithFormat:@"{%@,%@}",lat, lon]);
    return point;
}
