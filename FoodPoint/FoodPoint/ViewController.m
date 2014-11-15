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
    
    _buybutton addTarget:self action:@selector(buy) forControlEvents:<#(UIControlEvents)#>
    
    _defaults = [NSUserDefaults standardUserDefaults];
    [_defaults synchronize];
    
    
    
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
}

-(void) sell {
    NSLog(@"SELLBITCH");
}

@end
