//
//  Aboutus.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Aboutus.h"

@interface Aboutus ()

@end

@implementation Aboutus

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCallus:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"phone://0835773329"]];
}

- (IBAction)btnMailus:(id)sender {
      MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init]; [mailcontroller setMailComposeDelegate:self]; NSString *email =@"alongkot_ael@hotmail.com"; NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil]; [mailcontroller setToRecipients:emailArray]; [mailcontroller setSubject:nil]; [self presentViewController:mailcontroller animated:YES completion:nil]; 
}

- (void)mailComposeController :(MFMailComposeViewController *)controller didFinishWithResult : (MFMailComposeResult) result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
