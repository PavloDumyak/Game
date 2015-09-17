//
//  ViewController.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"
#import "MyCanvas.h"
#import "FigureController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction)beginNewGame:(id)sender;
@end
@implementation ViewController
@synthesize playerName = _playerName;
@synthesize score=_score;




-(void)viewDidLoad
{
 
   }


- (void) addPlayerName:(NSString*)name
{
    static int counter = 0;
    if(counter == 0){
        self.playerName = [[NSMutableArray alloc] initWithCapacity:10];
        self.score = [[NSMutableArray alloc] initWithCapacity:10];
    }
    counter++;
    [self.playerName addObject:name];
    NSLog(@"%@", [self.playerName objectAtIndex:0]);
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gameSegue"]){
        NSLog(@"test");
    }
    
    if([segue.identifier isEqualToString:@"leaderSegue"]){
    LeaderTableViewController *LTVCObject = (LeaderTableViewController*)segue.destinationViewController;
    [LTVCObject setPlayers:self.playerName];
        Saver* ob = [Saver sharedInstance];
        NSString *tmp = [NSString stringWithFormat:@"%i",ob.result];
        [self.score addObject:tmp];
        [LTVCObject setScores:self.score];
       
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self addPlayerName:[[alertView textFieldAtIndex:0] text]];
    [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier  isEqualToString: @"leaderSegue"])
    {
        return YES;
    }
    
    return NO;
}

- (IBAction)beginNewGame:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New player"
                                                    message:@"Write new player's name"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [self.view addSubview:alert];
    [alert show];
    
}
@end
