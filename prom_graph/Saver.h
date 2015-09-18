//
//  Saver.h
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Saver : NSObject
+(Saver*)sharedInstance;
-(void)initDictionary;
-(void)getScoreArray;
@property int result;
@property NSUserDefaults* pref;
@property NSMutableDictionary *myScoreRecords;
@property  NSString* currentName;
@property NSMutableArray* allNames;

@end
