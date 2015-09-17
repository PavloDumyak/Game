//
//  LeaderTableViewController.h
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray* players;
@property NSMutableArray* scores;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@end
