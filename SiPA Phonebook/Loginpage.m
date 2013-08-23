//
//  Loginpage.m
//  SiPAbook
//
//  Created by AelAdvance on 7/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Loginpage.h"
#import "Department.h"

@interface Loginpage ()
{
    UIAlertView *loading;
    NSString *test;
}
@end

@implementation Loginpage

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
    // Do any additional setup after loading the view from its nib.
    
    self.txtUsername.delegate = self;
    self.txtPassword.delegate = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"กรุณารอสักครู่..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [progress release];
    [loading show];
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    [loading release];

    // Tap Gesture for Hide Keyboard
    UITapGestureRecognizer *oneTapGesture = [[UITapGestureRecognizer alloc]
                                             initWithTarget: self
                                             action: @selector(hideKeyboard:)];
    [oneTapGesture setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:oneTapGesture];
}

- (void)hideKeyboard:(UITapGestureRecognizer *)sender {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txtUsername release];
    [_txtPassword release];
    [super dealloc];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (IBAction)btnClose:(id)sender
{
    exit(1);
}

- (IBAction)btnLogin:(id)sender {
    // Show Progress Loading...
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"กำลังเข้าสู่ระบบ..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [progress release];
    [loading show];
    
    
    //sUsername=weerachai&sPassword=weerachai@1"
    NSMutableString *post = [NSString stringWithFormat:@"sUsername=%@&sPassword=%@",[_txtUsername text],[_txtPassword text]];
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/Checklogin.php"];
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

- (IBAction)btnNext:(id)sender {
    Department *viewDepart = [self.storyboard instantiateViewControllerWithIdentifier:@"Tabview"];
    [self presentViewController:viewDepart animated:NO completion:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    sleep(3);
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
    
    // Hide Progress
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    // Return Status E.g : { "Status":"1", "MemberID":"1", "Message":"Login Successfully" }
    // 0 = Error
    // 1 = Completed
    
    if(receivedData)
    {
        /*NSString *Username1=[NSString stringWithFormat:@"%@",[txtUsername text]];
        NSString *Password1=[NSString stringWithFormat:@"%@",[txtPassword text]];*/
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // value in key name
        NSString *strStatus = [jsonObjects objectForKey:@"Status"];
        NSString *strMessage = [jsonObjects objectForKey:@"Message"];
        NSLog(@"Status = %@",strStatus);
        NSLog(@"Message = %@",strMessage);
    
        // Login Completed
        if( [strStatus isEqualToString:@"1"] ){
            
             UIAlertView *completed =[[UIAlertView alloc]
             initWithTitle:@":) Completed!"
             message:strMessage delegate:self
             cancelButtonTitle:@"ตกลง" otherButtonTitles: nil];
             [completed show];
             
            Department *viewDepart = [self.storyboard instantiateViewControllerWithIdentifier:@"Tabview"];
            [self presentViewController:viewDepart animated:YES completion:nil];
            /*Menupage *viewMenu = [[[Menupage alloc] initWithNibName:nil bundle:nil] autorelease];
            viewProfile.sUsername= Username1;
            viewProfile.sPassword= Password1;
            [self presentViewController:viewMenu animated:NO completion:NULL];*/
            
        }
        else // Login Failed
        {
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@":( Error!"
                                 message:strMessage delegate:self
                                 cancelButtonTitle:@"ตกลง" otherButtonTitles: nil];
            [error show];
        }
        
    }
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}

@end
