//
//  Name.h
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/5/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Name : UITableViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableViewObj;

- (IBAction)btnLogout:(id)sender;

@end
