//
//  SellIntermediateViewController.m
//  FoodPoint
//
//  Created by Brian Wang on 11/16/14.
//  Copyright (c) 2014 FoodPoint. All rights reserved.
//

#import "SellIntermediateViewController.h"

@implementation SellIntermediateViewController {
    NSUserDefaults *_defaults;
    BOOL *_addMode;
}

-(void) viewDidLoad {
    _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameTextField.delegate = self;
    _nameTextField.placeholder = @"Your Name Here!";
    
    _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailTextField.delegate = self;
    _emailTextField.placeholder = @"Your Email Here!";
    
    [_searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    _defaults = [NSUserDefaults standardUserDefaults];
}

-(void) search {
    if (_nameTextField.text.length == 0 || _emailTextField.text.length == 0) {
        _messageLabel.hidden = FALSE;
        return;
    }
    
    [self performSegueWithIdentifier:@"searchSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"searchSegue"]) {
        SellViewController *controller = (SellViewController*) segue.destinationViewController;
        Seller* mySeller = [[Seller alloc] initWithName:_nameTextField.text withEmail:_emailTextField.text];
        controller.thisSeller = mySeller;
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
