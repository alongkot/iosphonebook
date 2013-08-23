//
//  Loginpage.h
//  SiPAbook
//
//  Created by AelAdvance on 7/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Loginpage : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *txtUsername;
@property (retain, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnNext:(id)sender;
- (IBAction)btnClose:(id)sender;

@property (nonatomic,assign) NSMutableData *receivedData;


@end
