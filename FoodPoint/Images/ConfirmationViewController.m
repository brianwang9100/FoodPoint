//
//  ConfirmationViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "ConfirmationViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameOfMarket = @"Durham Farmer's Market";
    _date = @"11/15/2015";
    _nameOfMarketLabel.text = _nameOfMarket;
    
    [_confirmButton addTarget:self action:@selector(sendMail) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendMail {
    //Firebase
    NSString *baseURL = @"https://shining-heat-3529.firebaseio.com/";
    
    Firebase *rootRef = [[Firebase alloc] initWithUrl:baseURL];
    Firebase *buyersRef = [rootRef childByAppendingPath: @"buyers"];
    Firebase *marketsRef = [rootRef childByAppendingPath: @"markets"];
    Firebase *marketsSellerRef = [rootRef childByAppendingPath: [NSString stringWithFormat: @"markets/%@/sellers", @"-JarauDl-jU0nTDHz360"]];
//    
//    //set Label Date
//    [buyersRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
//        _date = [snapshot.value[_marketHashCode] valueForKey:@"date"];
//        _dateLabel.text = _date;
//    }];
    
    if (!_sent) {
        NSDictionary *seller = @{
//                                @"email": [NSString stringWithFormat: @"%@", _thisSeller.email],
                                 @"email": [NSString stringWithFormat:@"mattieoha@gmail.com"],
                                };
        
        Firebase *newSellerRef = [marketsSellerRef childByAppendingPath: @"Matt"];
        [newSellerRef setValue: seller];
        
        //mail
        
        NSDictionary *request = @{
                                  @"name": @"Rick",
                                  @"email": @"mattieoha@gmail.com",
                                  @"nameOfMarket" : @"Durham Farmers Market",
                                  @"dateOfMarket" : _date
                                  };
        
        Firebase *frequest = [rootRef childByAppendingPath: @"requestSeller/currentRequest"];
        [frequest setValue: request];
        _messageLabel.text = @"Sent!";
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
