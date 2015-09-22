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
    
    self.score  = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
    NSLog(@"%@", self.score);
   
    self.keys  = [self.score allKeys];
    self.values = [self.score allValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Saver *SObject = [Saver sharedInstance];
    return [self.score count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Saver *SObject = [Saver sharedInstance];
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [self.keys objectAtIndex:rows];
    cell.detailTextLabel.text = [self.values objectAtIndex:rows];
    
    
    
   /* NSLog(@"%@",self.scores);
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *tmpResult = [self.nameArray objectAtIndex:rows];
    NSString *result = tmpResult;
    tmpResult = [tmpResult stringByAppendingString:@"-------------------------------"];
    result=[tmpResult stringByAppendingString:[self.score objectForKey: @"Pavlo"]];
    
    cell.textLabel.text = result;
    
    //[SObject.sc objectAtIndex:rows];
 
    

   self.scoreLable.text = [self.scores objectAtIndex:rows];*/
    return cell;
}


@end
