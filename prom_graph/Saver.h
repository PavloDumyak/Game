//
//  Saver.h
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
// NSString* key = @"AllScore";
@interface Saver : NSObject
+(Saver*)sharedInstance;
-(void)initDictionary;
-(void)getScoreArray;
-(void)createDefaultSaver;
@property int result;
@property NSUserDefaults* defaultSaver;
@property NSMutableDictionary *myScoreRecords;
@property  NSString* currentName;
@property NSMutableArray* allNames;

@end
