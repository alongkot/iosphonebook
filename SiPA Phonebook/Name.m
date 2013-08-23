//
//  Name.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/5/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Name.h"
#import "Detail.h"
#import "Loginpage.h"

@interface Name ()
{
    NSMutableArray *allObject;
    NSMutableArray *displayObject;
    
    // A dictionary object
    NSDictionary *dict;
    
    // Define keys
    NSString *empid;
    NSString *nickname;
    NSString *name;
    NSString *department;
    NSString *email;
    NSString *mobile;
    NSString *telephone;
    NSString *picture;
}
@end

@implementation Name
@synthesize tableViewObj;

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
    
    self.tableViewObj.delegate = self;
    self.tableViewObj.dataSource = self;
    
    // Define keys
    empid = @"EmpID";
    nickname = @"Nickname";
    name = @"Name";
    department = @"Department";
    email = @"Email";
    mobile = @"Mobile";
    telephone = @"Telephone";
    picture = @"Picture";
    // Create array to hold dictionaries
    allObject = [[NSMutableArray alloc] init];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:@"http://localhost/Searchtwo.php"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    // values in foreach loop
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *strEmpID = [dataDict objectForKey:@"EmpID"];
        NSString *strNickname = [dataDict objectForKey:@"Nickname"];
        NSString *strName = [dataDict objectForKey:@"Name"];
        NSString *strDepartment = [dataDict objectForKey:@"Department"];
        NSString *strEmail = [dataDict objectForKey:@"Email"];
        NSString *strMobile = [dataDict objectForKey:@"Mobile"];
        NSString *strTelephone = [dataDict objectForKey:@"Telephone"];
        NSString *strPicture = [dataDict objectForKey:@"Picture"];
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                strEmpID, empid,
                strNickname, nickname,
                strName, name,
                strDepartment, department,
                strEmail, email,
                strMobile, mobile,
                strTelephone, telephone,
                strPicture, picture,nil];
        [allObject addObject:dict];
    }
    
    displayObject = [[NSMutableArray alloc] initWithArray:allObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [displayObject count];
        
    } else {
        return [allObject count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Use the default cell style.
        cell = [[[UITableViewCell alloc] initWithStyle : UITableViewCellStyleSubtitle
                                       reuseIdentifier : CellIdentifier]autorelease];
        
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSDictionary *tmpDict = [displayObject objectAtIndex:indexPath.row];
        
        // Picture
        NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:picture]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        // Nickname
        NSMutableString *text;
        text = [NSString stringWithFormat:@"%@ : %@",[tmpDict objectForKey:name],[tmpDict objectForKey:nickname]];
        
        // Name & Tel
        NSMutableString *detail;
        detail = [NSString stringWithFormat:@"%@ , Tel: %@"
                  ,[tmpDict objectForKey:department]
                  ,[tmpDict objectForKey:telephone]];
        cell.imageView.image = img;
        cell.textLabel.text = text;
        cell.detailTextLabel.text= detail;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor=[UIColor blueColor];
        cell.detailTextLabel.textColor=[UIColor blackColor];
    } else {
        NSDictionary *tmpDict = [allObject objectAtIndex:indexPath.row];
        
        // Picture
        NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:picture]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        // Nickname
        NSMutableString *text;
        text = [NSString stringWithFormat:@"%@ : %@",[tmpDict objectForKey:name],[tmpDict objectForKey:nickname]];
        
        // Name & Tel
        NSMutableString *detail;
        detail = [NSString stringWithFormat:@"%@ , Tel: %@"
                  ,[tmpDict objectForKey:department]
                  ,[tmpDict objectForKey:telephone]];
        cell.imageView.image = img;
        cell.textLabel.text = text;
        cell.detailTextLabel.text= detail;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor=[UIColor blueColor];
        cell.detailTextLabel.textColor=[UIColor blackColor];
    }
        return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        Detail *viewDetailsearch = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        if ([self.searchDisplayController isActive]) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSDictionary *tmpDict = [displayObject objectAtIndex:indexPath.row];
            viewDetailsearch.sNickname = [tmpDict objectForKey:nickname];
            viewDetailsearch.sName = [tmpDict objectForKey:name];
            viewDetailsearch.sDepartment = [tmpDict objectForKey:department];
            viewDetailsearch.sEmail = [tmpDict objectForKey:email];
            viewDetailsearch.sMobile = [tmpDict objectForKey:mobile];
            viewDetailsearch.sTelephone = [tmpDict objectForKey:telephone];
            viewDetailsearch.sImage = [tmpDict objectForKey:picture];
            
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            NSDictionary *tmpDict = [allObject objectAtIndex:indexPath.row];
            viewDetailsearch.sNickname = [tmpDict objectForKey:nickname];
            viewDetailsearch.sName = [tmpDict objectForKey:name];
            viewDetailsearch.sDepartment = [tmpDict objectForKey:department];
            viewDetailsearch.sEmail = [tmpDict objectForKey:email];
            viewDetailsearch.sMobile = [tmpDict objectForKey:mobile];
            viewDetailsearch.sTelephone = [tmpDict objectForKey:telephone];
            viewDetailsearch.sImage = [tmpDict objectForKey:picture];
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{    
    if([searchString length] == 0)
    {
        [displayObject removeAllObjects];
        [displayObject addObjectsFromArray:allObject];
    }
    else
    {
        [displayObject removeAllObjects];
        for(NSDictionary *tmpDict in allObject)
        {
            NSString *val = [tmpDict objectForKey:name];
            
            NSRange r = [val rangeOfString:searchString options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound)
            {
                [displayObject addObject:tmpDict];
            }
        }
    }
       return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"showDetail" sender: self];
    }
}

- (void)dealloc {
    [tableViewObj release];
    [super dealloc];
}

- (IBAction)btnLogout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"\n"
                          @"ออกจากระบบ"
                          message:@"คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?"
                          delegate: self
                          cancelButtonTitle:@"ยกเลิก"
                          otherButtonTitles:@"ยืนยัน", nil];
    
    UIImageView *imglogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconabout2.png"]];
	imglogo.contentMode = UIViewContentModeScaleToFill;
	imglogo.frame = CGRectMake(120, 10, 40, 30);//(ซ้าย,บน,ขวา,ล่าง)
    [alert addSubview:imglogo];
    
    [imglogo release];

    [[[alert valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [[[alert valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [UIApplication sharedApplication];
            Loginpage *viewLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Loginview"];
            [self presentViewController:viewLogin animated:NO completion:nil];
            break;
        default:
            break;
    }
}

@end
