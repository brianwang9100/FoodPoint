//
//  Buyer.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "Buyer.h"

@implementation Buyer

-(id) initWithName:(NSString*) name withEmail: (NSString*) email {
    _name = name;
    _email = email;
    return self;
}

@end