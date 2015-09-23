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



-(instancetype)initFeature:(SCFeatureType)typeOfFeature:(CGPoint)xy
{
    
        self.currentRect = CGRectMake(xy.x, xy.y, 100, 100);
       self.backgroundColor = [UIColor blueColor];
        [self setCoords:xy];
   
  
    if (self = [super initWithFrame:self.currentRect])
    {
        self.selectedType = typeOfFeature;
    }
    return self;
}





-(void)choiceYourFeature:(CGRect)rect
{

    UIImageView *imageHolder;
    UIImage *image;
    switch (self.selectedType)
    {
        case 0:
            imageHolder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            image= [UIImage imageNamed:@"toxic.jpg"];
            imageHolder.image = image;
            break;
            
        case 1:
            imageHolder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            image= [UIImage imageNamed:@"toxic.jpg"];
            imageHolder.image = image;
            break;
        case 2:
            imageHolder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            image= [UIImage imageNamed:@"toxic.jpg"];
            imageHolder.image = image;
            break;
        case 3:
            imageHolder=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            image= [UIImage imageNamed:@"toxic.jpg"];
            imageHolder.image = image;
            break;
            
        default:
            break;
    }
    imageHolder.userInteractionEnabled = YES;
    [self addSubview:imageHolder];
   
}




- (void)drawRect:(CGRect)rect
{
   
    
    self.backgroundColor = [UIColor clearColor];
    
   // rect = CGRectInset(rect, rect.size.width/100*2, rect.size.height/100*2);
    [self choiceYourFeature:rect];
}


@end
