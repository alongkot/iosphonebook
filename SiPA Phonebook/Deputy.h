//
//  Deputy.h
//  SiPA Phonebook
//
//  Created by AelAdvance on 8/8/56 BE.
//  Copyright (c) 2556 AelAdvance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Deputy : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITableView *myTable;
}

@property (nonatomic, assign) NSMutableData *receivedData;

@end
