//
//  Firstpage.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Firstpage.h"
#import "Loginpage.h"
#import "Reachability.h"

@interface Firstpage ()

@end

@implementation Firstpage

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
    
    // for Tap
    UITapGestureRecognizer *oneTapGesture = [[UITapGestureRecognizer alloc]
                                             initWithTarget: self
                                             action: @selector(oneTapGestureHandle:)];
    [oneTapGesture setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:oneTapGesture];
    [self checkForWIFIConnection];
}

- (void)oneTapGestureHandle:(UITapGestureRecognizer *)sender {
    NSLog(@"กดแล้วครับ");
    [self performSegueWithIdentifier:@"Login2" sender:sender];
    
    Loginpage *viewLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Loginview"];
    [self presentViewController:viewLogin animated:YES completion:nil];
    
}

- (void)checkForWIFIConnection {
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ไม่มี WiFi ที่ใช้ได้", @"AlertView")
                                                            message:NSLocalizedString(@"คุณไม่ได้เชื่อมต่อ WiFi กรุณาทำการเชื่อมต่อ WiFi", @"AlertView")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"ยกเลิก", @"AlertView")
                                  
                                                  otherButtonTitles:NSLocalizedString(@"เปิดการตั้งค่า WiFi", @"AlertView"), nil];
        
        [alertView show];
        
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) { exit(1);
        
        // means share button pressed
        // write your code here to do whatever you want to do once the share button is pressed
    }
    if(buttonIndex == 1) {  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
        // means apple button pressed
        
        
        // write your code here to do whatever you want to do once the apple button is pressed
    }
    // and so on for the last button
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
