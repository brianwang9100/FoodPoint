//
//  Market.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "Market.h"

@implementation Market

-(id) initWithLat:(float) lat
          withLon:(float) lon
        withMonth:(int) month
          withDay:(int) day
         withYear:(int) year {
    
    _lat = lat;
    _lon = lon;
    
    _date = [[NSDateComponents alloc] init];
    [_date setYear: year];
    [_date setMonth: month];
    [_date setDay: day];
    
    _thisHashCode = [self hashcode];
    return self;
}

-(int) hashcode {
    int result = 17;
    result = result * 31 + _lat;
    result = result * 31 + _lon;
    result = result * 31 + _date.month;
    result = result * 31 + _date.day;
    result = result * 31 + _date.year;
    return result;
}
@end
