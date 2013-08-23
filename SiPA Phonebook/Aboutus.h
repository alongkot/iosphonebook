//
//  Aboutus.h
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Aboutus : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)btnCallus:(id)sender;
- (IBAction)btnMailus:(id)sender;

@end
