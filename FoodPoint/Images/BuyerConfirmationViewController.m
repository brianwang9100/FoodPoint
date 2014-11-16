//
//  BuyerConfirmationViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "BuyerConfirmationViewController.h"

@interface BuyerConfirmationViewController ()

@end

@implementation BuyerConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameOfMarket = @"Durham Farmer's Market";
    _date = @"11/15/2015";
    _nameOfMarketLabel.text = _nameOfMarket;
    
    [_confirmButton addTarget:self action:@selector(addToList) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addToList {
    //Firebase
    NSString *baseURL = @"https://shining-heat-3529.firebaseio.com/";
    
    Firebase *rootRef = [[Firebase alloc] initWithUrl:baseURL];
    Firebase *buyersRef = [rootRef childByAppendingPath: @"buyers"];
    Firebase *marketsRef = [rootRef childByAppendingPath: @"markets"];
    Firebase *marketsBuyersRef = [rootRef childByAppendingPath: [NSString stringWithFormat: @"markets/%@/buyers", @"-JarauDl-jU0nTDHz360"]];
    //
    //    //set Label Date
    //    [buyersRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
    //        _date = [snapshot.value[_marketHashCode] valueForKey:@"date"];
    //        _dateLabel.text = _date;
    //    }];
    
    if (!_sent) {
        NSDictionary *buyer = @{
                                //@"email": [NSString stringWithFormat: @"%@", _thisSeller.email],
                                 @"email": @"mattieoha@gmail.com",
                                 };
        
        Firebase *newSellerRef = [marketsBuyersRef childByAppendingPath: _thisBuyer.name];
        [newSellerRef setValue: buyer];
        
        _messageLabel.text = [NSString stringWithFormat:@"%@ has been added!", _thisBuyer.name];
        _sent = true;
    }
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
