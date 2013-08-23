//
//  Direct.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Direct.h"

@interface Direct ()

@end

@implementation Direct

@synthesize receivedData;

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

    
    NSMutableString *post = [NSString stringWithFormat:@"sEmpID=19002"];
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/Datadirector.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    if (theConnection) {
        self.receivedData = [[NSMutableData data] retain];
    } else {
		UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"Failed in viewDidLoad"  delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[connectFailMessage show];
		[connectFailMessage release];
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [connection release];
    [receivedData release];
    
    // inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
    [didFailWithErrorMessage release];
	
    //inform the user
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if(receivedData)
    {
        //NSLog(@"%@",receivedData);
        
        //NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",dataString);
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // value in key name
        NSString *strNickname = [jsonObjects objectForKey:@"Nickname"];
        NSString *strName = [jsonObjects objectForKey:@"Name"];
        NSString *strDepartment = [jsonObjects objectForKey:@"Department"];
        NSString *strEmail = [jsonObjects objectForKey:@"Email"];
        NSString *strMobile = [jsonObjects objectForKey:@"Mobile"];
        NSString *strTelephone = [jsonObjects objectForKey:@"Telephone"];
        NSString *strPicture = [jsonObjects objectForKey:@"Picture"];
        
        NSLog(@"Nickname = %@",strNickname);
        NSLog(@"Name = %@",strName);
        NSLog(@"Department = %@",strDepartment);
        NSLog(@"Email = %@",strEmail);
        NSLog(@"Mobile = %@",strMobile);
        NSLog(@"Telephone = %@",strTelephone);
        NSLog(@"Picture = %@",strPicture);
        
        lblNickname.text = strNickname;
        lblName.text = strName;
        lblDepartment.text = strDepartment;
        lblEmail.text = strEmail;
        lblMobile.text = strMobile;
        lblTelephone.text = strTelephone;
        
        NSURL *url = [NSURL URLWithString:[strPicture description]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        imgViewImage.image = img;
        
    }
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}


- (IBAction)btnMail:(id)sender {
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init]; [mailcontroller setMailComposeDelegate:self]; NSString *email =lblEmail.text; NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil]; [mailcontroller setToRecipients:emailArray]; [mailcontroller setSubject:nil]; [self presentViewController:mailcontroller animated:YES completion:nil];
}

- (void)mailComposeController :(MFMailComposeViewController *)controller didFinishWithResult : (MFMailComposeResult) result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)btnPhone:(id)sender {
    NSCharacterSet *specialCharSet = [NSCharacterSet characterSetWithCharactersInString:@" )(-,"];
    NSArray *components = [lblMobile.text componentsSeparatedByCharactersInSet:specialCharSet];
    NSString *callStr = [components componentsJoinedByString:@""];
    callStr = [NSString stringWithFormat:@"mobile:%@", callStr];
    NSURL *url = [[NSURL alloc] initWithString:callStr];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [imgViewImage release];
    [lblNickname release];
    [lblName release];
    [lblEmail release];
    [lblMobile release];
    [lblDepartment release];
    [lblTelephone release];
    [super dealloc];
}

@end
