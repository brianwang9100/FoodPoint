//
//  ViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController {
    NSUserDefaults *_defaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameTextField.delegate = self;
    _nameTextField.placeholder = @"Your Name Here";
    
    [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_sellButton addTarget:self action:@selector(sell) forControlEvents:UIControlEventTouchUpInside];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    
//    
//    NSString *baseURL = @"https://shining-heat-3529.firebaseio.com/";
//    
//    Firebase *rootRef = [[Firebase alloc] initWithUrl:baseURL];
//    Firebase *buyersRef = [rootRef childByAppendingPath: @"buyers"];
//    Firebase *marketsRef = [rootRef childByAppendingPath: @"markets"];
//    
//   
//    [[marketsRef queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
//        //CGPoint point = [self convertToLocation: snapshot];
//        //NSLog([NSString stringWithFormat:@"%f, %f", point.x, point.y]);
//        NSUInteger *numSellers = snapshot.childrenCount;
//        NSLog([NSString stringWithFormat:@"%tu", numSellers]);
//        //2014-11-15 22:36:33.833 FoodPoint[19894:15635194] 49.753450, 302.345454
//        //2014-11-15 22:36:33.834 FoodPoint[19894:15635194] -49.000000, 203.000000
//        //2014-11-15 22:36:33.834 FoodPoint[19894:15635194] 3.000000, 35.000000
//    }];
//    
//    
    //  set a buyer in firebase
    BOOL trans = true;
    NSString *email = @"hello@comp.io";
    
    NSNumber *lat = @36.009160;
    NSNumber *lon = @-78.945673;
    
     NSDictionary *buyer = @{
         @"lat": lat,
         @"lon": lon,
         @"trans": [NSString stringWithFormat:@"%d", trans],
         @"email": email
     };
    
     Firebase *newBuyerRef = [buyersRef childByAppendingPath:@"Harry"];
     [newBuyerRef setValue: buyer];
    
    
    
    
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [_nameTextField resignFirstResponder];
    return NO;
}

-(void) buy {
    NSLog(@"BUYBITCH");
    if (_nameTextField.text.length == 0) {
        _messageLabel.text = @"Please enter a name!";
        _messageLabel.hidden = FALSE;
        return;
    }
    
    [_defaults setObject:_nameTextField.text forKey:@"buyerName"];
    [_defaults synchronize];
    
    [self performSegueWithIdentifier:@"buySegue" sender:self];
    
    
}

-(void) sell {
    NSLog(@"SELLBITCH");
    if (_nameTextField.text.length == 0) {
        _messageLabel.text = @"Please enter a name!";
        return;
    }
    
    [_defaults setObject:_nameTextField.text forKey:@"sellerName"];
    [_defaults synchronize];
}

@end
