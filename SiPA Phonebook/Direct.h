//
//  Direct.h
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Direct : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UIImageView *imgViewImage;
    IBOutlet UILabel *lblNickname;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDepartment;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblMobile;
    IBOutlet UILabel *lblTelephone;
    
}

- (IBAction)btnMail:(id)sender;
- (IBAction)btnPhone:(id)sender;
- (IBAction)btnCall:(id)sender;


@property (strong ,nonatomic) id sEmpID;

@property (nonatomic,assign) NSMutableData *receivedData;

@end
