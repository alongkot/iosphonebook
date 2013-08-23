//
//  Deputy.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Deputy.h"
#import "Detail.h"

@interface Deputy ()
{
    NSMutableArray *myObject;
    
    // A dictionary object
    NSDictionary *dict;
    
    // Define keys
    NSString *empid;
    NSString *nickname;
    NSString *name;
    NSString *department;
    NSString *email;
    NSString *mobile;
    NSString *tel;
    NSString *picture;
    
    UIAlertView *loading;
}

@end

@implementation Deputy

@synthesize receivedData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Define keys
    empid = @"EmpID";
    nickname = @"Nickname";
    name = @"Name";
    department = @"Department";
    email = @"Email";
    mobile = @"Mobile";
    tel = @"Telephone";
    picture = @"Picture";
    
    // Create array to hold dictionaries
    myObject = [[NSMutableArray alloc] init];
    
    NSMutableString *post = [NSString stringWithFormat:@"keyword3=รองผู้อำนวยการ"];
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/Search.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // Loading...
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"กรุณารอสักครู่" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [progress release];
    [loading show];
    
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
    sleep(2);
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    if(receivedData)
    {
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // values in foreach loop
        for (NSDictionary *dataDict in jsonObjects) {
            NSString *strNickname = [dataDict objectForKey:@"Nickname"];
            NSString *strName = [dataDict objectForKey:@"Name"];
            NSString *strDepartment = [dataDict objectForKey:@"Department"];
            NSString *strEmail = [dataDict objectForKey:@"Email"];
            NSString *strMobile = [dataDict objectForKey:@"Mobile"];
            NSString *strTelephone = [dataDict objectForKey:@"Telephone"];
            NSString *strPicture = [dataDict objectForKey:@"Picture"];
            
            
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                    strNickname, nickname,
                    strName, name,
                    strDepartment, department,
                    strEmail, email,
                    strMobile, mobile,
                    strTelephone, tel,
                    strPicture, picture,
                    nil];
            [myObject addObject:dict];
        }
        
        [myTable reloadData];
    }
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int nbCount = [myObject count];
    if (nbCount == 0)
        return 1;
    else
        return [myObject count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Use the default cell style.
        cell = [[[UITableViewCell alloc] initWithStyle : UITableViewCellStyleSubtitle
                                       reuseIdentifier : CellIdentifier] autorelease];
        
        cell.textLabel.textColor=[UIColor blueColor];
        cell.detailTextLabel.textColor=[UIColor blackColor];
        
    }
    int nbCount = [myObject count];
    if (nbCount ==0)
        cell.textLabel.text = @"กำลังโหลดข้อมูล...";
    else
    {
        NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
        
        // MemberID
        NSMutableString *text;
        text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:name]];
        
        // Name & Tel
        NSMutableString *detail;
        detail = [NSString stringWithFormat:@"โทร: %@, %@"
                  ,[tmpDict objectForKey:mobile],[tmpDict objectForKey:tel]];
        
        NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:picture]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        cell.imageView.image = img;
        cell.textLabel.text = text;
        cell.detailTextLabel.text= detail;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] setNicknameItem:[tmpDict objectForKey:nickname]];
        [[segue destinationViewController] setNameItem:[tmpDict objectForKey:name]];
        [[segue destinationViewController] setDepartmentItem:[tmpDict objectForKey:department]];
        [[segue destinationViewController] setEmailItem:[tmpDict objectForKey:email]];
        [[segue destinationViewController] setTelephoneItem:[tmpDict objectForKey:tel]];
        [[segue destinationViewController] setMobileItem:[tmpDict objectForKey:mobile]];
        [[segue destinationViewController] setImageItem:[tmpDict objectForKey:picture]];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [myTable release];
    [super dealloc];
}

@end
