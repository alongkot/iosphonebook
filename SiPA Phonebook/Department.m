//
//  Department.m
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/14/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import "Department.h"
#import "Loginpage.h"

@interface Department ()
{
    NSMutableArray *allObject;
    NSMutableArray *displayObject;
    
}
@end

@implementation Department

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

    // Create array to hold dictionaries
     allObject = [NSMutableArray arrayWithObjects:@"รองผู้อำนวยการ",@"ยุทธศาสตร์และแผนงาน",@"พัฒนาบุคคลากรและวิชาการ",@"บริหารทั่วไป",@"บริหารความเสี่ยงและควบคุมภายใน",
                  @"กฏหมาย",@"ส่งเสริมและพัฒนาเทคโนโลยี",@"ตรวจสอบ",@"มาตรฐานการส่งเสริม",@"สื่อสารองค์กร",@"พัฒนาผู้ประกอบการ",@"ทรัพยากรบุคคล",@"บัญชี การเงิน งบประมาณ",@"ส่งเสริมการตลาด Enterprise",@"ส่งเสริมการตลาด Digital", nil];

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
        return [displayObject count];
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
        
        // Department
        NSMutableString *text= [displayObject objectAtIndex:indexPath.row];
        cell.textLabel.text = text;
        cell.textLabel.textColor=[UIColor blackColor];

 return cell;
   
}

#pragma mark - Table view delegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}*/

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
