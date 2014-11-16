//
//  Buyer.h
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Buyer : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSString *email;
@property (assign, nonatomic) BOOL trans;
-(id) initWithName:(NSString*) name withEmail: (NSString*) email;
@end