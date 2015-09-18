//
//  ViewController.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaderTableViewController.h"
#import "MyCanvas.h"
#import "Saver.h"
@interface ViewController : UIViewController
@property  NSMutableArray *playerName;
@property  NSMutableArray *score;
@property NSMutableDictionary* nScore;
@property (nonatomic, assign) NSUserDefaults *prefs;
@end

