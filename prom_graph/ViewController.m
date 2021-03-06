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
#import "SpecialFeatures.h"
#import "MusicPlayer.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction)beginNewGame:(id)sender;
@end
@implementation ViewController
@synthesize playerName = _playerName;
@synthesize score=_score;




- (void)viewDidLoad
{
    static int count  = 0;
    
    if(count == 0)
    {
        self.nScore = [[NSMutableDictionary alloc]initWithCapacity:10];
        
       self.prefs = [NSUserDefaults standardUserDefaults];
        [self.prefs setInteger:100 forKey:@""];
        
    }
    count++;
    
    NSLog(@"%li", (long)[self.prefs integerForKey:@"Pavlo"]);
  
    [self.navigationItem setHidesBackButton:YES];
      musicPlayer *ob = [musicPlayer sharedInstance];
    NSInteger gMusicStatus = [[NSUserDefaults standardUserDefaults] integerForKey:@"musicstatus"];
    if(gMusicStatus != 1)
    {
       [ob playMusic];
    }
  
   
    
    NSInteger gStatus = [[NSUserDefaults standardUserDefaults] integerForKey:@"gamestatus"];
    
    if(gStatus == 1)
    {
        [self.gameStatus setTitle:@"Resume" forState:UIControlStateNormal];
    }
    
   }



- (IBAction)playOrStopMusic:(id)sender
{
    musicPlayer *ob = [musicPlayer sharedInstance];
    
    if([self.button.titleLabel.text isEqualToString:@"Play Music"])
    {
        [self.button setTitle:@"Stop" forState:UIControlStateNormal];
        [ob playMusic];
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"musicstatus"];
    }
    
    else
    {   [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"musicstatus"];
        [self.button setTitle:@"Play Music" forState:UIControlStateNormal];
        [ob stopMusic];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gameSegue"])
    {
        NSLog(@"test");
    }
    
    if([segue.identifier isEqualToString:@"leaderSegue"])
    {
    LeaderTableViewController *LTVCObject = (LeaderTableViewController*)segue.destinationViewController;
    [LTVCObject setPlayers:self.playerName];
        Saver* ob = [Saver sharedInstance];
        NSString *tmp = [NSString stringWithFormat:@"%i",ob.result];
        [self.score addObject:tmp];
        [LTVCObject setScores:self.score];
    }
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier  isEqualToString: @"leaderSegue"])
    {
        return YES;
    }
    
    return NO;
}

- (IBAction)beginNewGame:(id)sender
{
      [self performSegueWithIdentifier:@"gameSegue" sender:nil];
}
@end
