//
//  Detail.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/5/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Detail.h"

@interface Detail ()

@end

@implementation Detail

/*@synthesize lblNickname;
@synthesize lblName;
@synthesize lblDepartment;
@synthesize lblEmail;
@synthesize lblTelephone;
@synthesize lblMobile;
@synthesize imgViewImage;*/

@synthesize sNickname,sName,sDepartment,sEmail,sTelephone,sMobile,sImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSURL *url = [NSURL URLWithString:[sImage description]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    
    imgViewImage.image = img;
    lblNickname.text = [sNickname description];
    lblName.text = [sName description];
    lblDepartment.text = [sDepartment description];
    lblEmail.text = [sEmail description];
    lblMobile.text = [sMobile description];
    lblTelephone.text = [sTelephone description];


}

- (void)setNameItem:(id)newName
{
    sName = newName;
}

- (void)setNicknameItem:(id)newNickname
{
    sNickname = newNickname;
}

- (void)setDepartmentItem:(id)newDepartment
{
    sDepartment = newDepartment;
}

- (void)setEmailItem:(id)newEmail
{
    sEmail = newEmail;
}

- (void)setTelephoneItem:(id)newTelephone
{
    sTelephone = newTelephone;
}

- (void)setMobileItem:(id)newMobile
{
    sMobile = newMobile;
}

- (void)setImageItem:(id)newImage
{
    sImage = newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSendemail:(id)sender {
   MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];[mailcontroller setMailComposeDelegate:self]; NSString *email =lblEmail.text; NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil]; [mailcontroller setToRecipients:emailArray]; [mailcontroller setSubject:nil]; [self presentViewController:mailcontroller  animated:YES completion:nil];
    //[[UINavigationBar appearance] setTintColor:[UIColor bl]];//Title color
}

- (IBAction)btnPhone:(id)sender {
    NSCharacterSet *specialCharSet = [NSCharacterSet characterSetWithCharactersInString:@" )(-,"];
    NSArray *components = [lblMobile.text componentsSeparatedByCharactersInSet:specialCharSet];
    NSString *phoneStr = [components componentsJoinedByString:@""];
    phoneStr = [NSString stringWithFormat:@"telephone:%@", phoneStr];
    NSURL *url = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)btnCall:(id)sender {
    NSCharacterSet *specialCharSet = [NSCharacterSet characterSetWithCharactersInString:@" )(-,"];
    NSArray *components = [lblTelephone.text componentsSeparatedByCharactersInSet:specialCharSet];
    NSString *callStr = [components componentsJoinedByString:@""];
    callStr = [NSString stringWithFormat:@"mobile:%@", callStr];
    NSURL *url = [[NSURL alloc] initWithString:callStr];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)mailComposeController :(MFMailComposeViewController *)controller didFinishWithResult : (MFMailComposeResult) result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc {
    [imgViewImage release];
    [lblName release];
    [lblNickname release];
    [lblDepartment release];
    [lblEmail release];
    [lblTelephone release];
    [lblMobile release];
    [super dealloc];
}
@end
