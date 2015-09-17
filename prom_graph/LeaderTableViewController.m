//
//  LeaderTableViewController.m
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "LeaderTableViewController.h"

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
    return [self.players count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@",self.scores);
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.players objectAtIndex:rows];
    
    
    
   self.scoreLable.text = [self.scores objectAtIndex:rows];
    return cell;
}


@end
