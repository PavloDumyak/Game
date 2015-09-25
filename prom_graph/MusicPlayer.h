//
//  MusicPlayer.h
//  prom_graph
//
//  Created by Admin on 25.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface musicPlayer : NSObject<AVAudioPlayerDelegate>
+(instancetype)sharedInstance;
-(void)playMusic;
-(void)stopMusic;
@property (nonatomic)AVAudioPlayer *audioPlayer;
@end
