//
//  BuyIntermediateViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "BuyIntermediateViewController.h"


@implementation BuyIntermediateViewController {
    NSUserDefaults *_defaults;
    BOOL _trans;
}

-(void) viewDidLoad {
    _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameTextField.delegate = self;
    _nameTextField.placeholder = @"Your Name Here!";
    
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailTextField.delegate = self;
    _emailTextField.placeholder = @"Your Email Here!";
    
    [_walkingButton addTarget:self action:@selector(walk) forControlEvents:UIControlEventTouchUpInside];
    [_driveButton addTarget:self action:@selector(drive) forControlEvents:UIControlEventTouchUpInside];
    
    _defaults = [NSUserDefaults standardUserDefaults];
}

-(void) walk {
    if (_nameTextField.text.length == 0 || _emailTextField.text.length == 0) {
        _messageLabel.hidden = FALSE;
        return;
    }
    _trans = false;
    [self performSegueWithIdentifier:@"segue" sender:self];
}

-(void) drive {
    if (_nameTextField.text.length == 0 || _emailTextField.text.length == 0) {
        _messageLabel.hidden = FALSE;
        return;
    }
    _trans = true;
    [self performSegueWithIdentifier:@"segue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segue"]) {
        BuyViewController *controller = (BuyViewController*) segue.destinationViewController;
        Buyer* myBuyer = [[Buyer alloc] initWithName:_nameTextField.text withEmail:_emailTextField.text];
        controller.trans = _trans;
        controller.thisBuyer = myBuyer;
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
@end
