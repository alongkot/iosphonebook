//
//  Detail.h
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/5/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Detail : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UIImageView *imgViewImage;
    IBOutlet UILabel *lblNickname;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDepartment;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblMobile;
    IBOutlet UILabel *lblTelephone;
}
/*@property (strong, nonatomic) IBOutlet UIImageView *imgViewImage;
@property (strong, nonatomic) IBOutlet UILabel *lblNickname;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDepartment;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblMobile;
@property (strong, nonatomic) IBOutlet UILabel *lblTelephone;*/

@property (strong, nonatomic) id sImage;
@property (strong, nonatomic) id sNickname;
@property (strong, nonatomic) id sName;
@property (strong, nonatomic) id sDepartment;
@property (strong, nonatomic) id sEmail;
@property (strong, nonatomic) id sMobile;
@property (strong, nonatomic) id sTelephone;

//@property (strong, nonatomic) id detailItem;

- (void)setNameItem:(id)newName;
- (void)setNicknameItem:(id)newNickname;
- (void)setDepartmentItem:(id)newDepartment;
- (void)setEmailItem:(id)newEmail;
- (void)setTelephoneItem:(id)newTelephone;
- (void)setMobileItem:(id)newMobile;
- (void)setImageItem:(id)newImage;

- (IBAction)btnSendemail:(id)sender;
- (IBAction)btnPhone:(id)sender;
- (IBAction)btnCall:(id)sender;


@end
