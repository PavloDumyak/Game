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
    self.keys  = [self.score keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    self.keys2 = [NSMutableArray arrayWithArray: self.keys];
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
        NSString *tmp = [self.keys objectAtIndex: indexPath.row];
        [self.score removeObjectForKey:tmp];
        [self.keys2 removeObjectAtIndex:indexPath.row];
        [self.values removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"leader"];
        [[NSUserDefaults standardUserDefaults]setObject:self.score forKey:@"leader"];
        [tableView reloadData];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keys2 count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSInteger rows = [indexPath row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(![self.keys2 isEqual:nil])
    {
        cell.textLabel.text = [self.keys2 objectAtIndex:rows];
        cell.detailTextLabel.text = [self.score objectForKey:[self.keys2 objectAtIndex:rows]];
    }
    
    return cell;
}


@end
