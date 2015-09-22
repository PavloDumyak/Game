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
    self.keys  =  [NSMutableArray arrayWithArray:[self.score allKeys]];
    self.values = [NSMutableArray arrayWithArray:[self.score allValues]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"leader"];
        [self viewDidLoad];
        [tableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keys count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(![self.keys isEqual:nil])
    {
    cell.textLabel.text = [self.keys objectAtIndex:rows];
    cell.detailTextLabel.text = [self.values objectAtIndex:rows];
    }
    
    
  
    return cell;
}


@end
