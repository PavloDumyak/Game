//
//  SpecialFeatures.m
//  prom_graph
//
//  Created by Pavlo Dumyak on 9/21/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "SpecialFeatures.h"

@implementation SpecialFeatures
@synthesize coords=_coords;



- (instancetype)initFeature:(SCFeatureType)typeOfFeature :(CGPoint)xy
{
    
    self.currentRect = CGRectMake(xy.x, xy.y, 100, 100);
    
    [self setCoords:xy];
   
    if (self = [super initWithFrame:self.currentRect])
    {
        self.selectedType = typeOfFeature;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)choiceYourFeature:(CGRect)rect
{
    UIImageView *imageHolder;
    UIImage *image;
            imageHolder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            image= [UIImage imageNamed:@"feature.png"];
            imageHolder.image = image;
    imageHolder.userInteractionEnabled = YES;
    [self addSubview:imageHolder];
   
}




- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    [self choiceYourFeature:rect];
}


@end
