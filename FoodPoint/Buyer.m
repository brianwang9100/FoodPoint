//
//  Buyer.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "Buyer.h"

@implementation Buyer

-(id) initWithName:(NSString*) name withEmail: (NSString*) email withTrans: (BOOL) trans {
    _name = name;
    _email = email;
    _trans = trans;
    return self;
}

@end