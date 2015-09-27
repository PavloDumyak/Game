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
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController : UIViewController<AVAudioPlayerDelegate>
@property  NSMutableArray *playerName;
@property  NSMutableArray *score;
@property NSMutableDictionary* nScore;
@property  AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) NSUserDefaults *prefs;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *gameStatus;
@end

