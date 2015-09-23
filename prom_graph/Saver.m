//
//  Saver.m
//  prom_graph
//
//  Created by Admin on 17.09.15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "Saver.h"


@implementation Saver
@synthesize myScoreRecords=_myScoreRecords;
@synthesize allNames=_allNames;

+ (Saver*)sharedInstance
{
    static Saver* object;
    static dispatch_once_t predicat;
    dispatch_once(&predicat, ^{object = [[Saver alloc]init];});
   [object initDictionary];
    return object;
}


- (void)initDictionary
{
    static BOOL flag = NO;
    if(flag==NO)
    {
        self.defaultSaver = [NSUserDefaults standardUserDefaults];
        self.myScoreRecords = [[NSMutableDictionary alloc]initWithCapacity:10];
        self.allNames = [[NSMutableArray alloc] initWithCapacity:10];
    }
   
    flag = YES;
}
@end
