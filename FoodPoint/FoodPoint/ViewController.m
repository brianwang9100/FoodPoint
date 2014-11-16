//
//  ViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/15/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "ViewController.h"
#import "BuyViewController.h"

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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"buySegue"]){
        BuyViewController *controller = (BuyViewController*) segue.destinationViewController;
        controller.
    }
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
