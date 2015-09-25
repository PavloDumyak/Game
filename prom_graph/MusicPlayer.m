//
//  MusicPlayer.m
//  prom_graph
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "MusicPlayer.h"

@implementation musicPlayer
@synthesize audioPlayer=_audioPlayer;
+ (musicPlayer*)sharedInstance
{
    static musicPlayer* object;
    static dispatch_once_t predicat;
    dispatch_once(&predicat, ^{object = [[musicPlayer alloc]init];
    });
    return object;
}

-(void)playMusic
{
    musicPlayer *ob = [musicPlayer sharedInstance];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mainTheme" ofType:@"mp3"];
    ob.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    ob.audioPlayer.delegate = ob;
    ob.audioPlayer.numberOfLoops = -1;
    [ob.audioPlayer play];
}

-(void)stopMusic
{
     musicPlayer *ob = [musicPlayer sharedInstance];
    [ob.audioPlayer stop];
}

@end
