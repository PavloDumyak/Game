//
//  LeaderTableViewController.m
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "LeaderTableViewController.h"
#import "Saver.h"
@interface LeaderTableViewController ()

@end

@implementation LeaderTableViewController

@synthesize players=_players;
@synthesize scores=_scores;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Saver *SObject = [Saver sharedInstance];
    return [SObject.myScoreRecords count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Saver *SObject = [Saver sharedInstance];
    
    NSLog(@"%@",self.scores);
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *tmpResult = [SObject.allNames objectAtIndex:rows];
    NSString *result = tmpResult;
    tmpResult = [tmpResult stringByAppendingString:@"-------------------------------"];
    result=[tmpResult stringByAppendingString:[SObject.myScoreRecords objectForKey: result]];
    
    cell.textLabel.text = result;
    
    //[SObject.sc objectAtIndex:rows];
 
    
   
    
    
   self.scoreLable.text = [self.scores objectAtIndex:rows];
    return cell;
}


@end
