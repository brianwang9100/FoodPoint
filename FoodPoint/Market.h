//
//  Market.h
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Market : NSObject
@property (assign, nonatomic) float lat;
@property (assign, nonatomic) float lon;
@property (assign, nonatomic) int thisHashCode;
@property (strong, nonatomic) NSDateComponents *date;
-(id) initWithLat:(float) lat
          withLon:(float) lon
        withMonth:(int) month
          withDay:(int) day
         withYear:(int) year;
@end
