//
//  SpecialFeatures.m
//  prom_graph
//
//  Created by Pavlo Dumyak on 9/21/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "SpecialFeatures.h"

@implementation SpecialFeatures




-(instancetype)initFeature:(SCFeatureType)typeOfFeature
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 70, 70)])
    {
        self.selectedType = SCFeatureBomb;
    }
    return self;
}



-(void)choiceYourFeature:(CGRect)rect
{
   
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    UIImage *image;
        
    switch (self.selectedType)
    {
        case 0:
              image= [UIImage imageNamed:@"toxic.jpg"];
            break;
            
        default:
            break;
    }
    
    imageHolder.image = image;
    [self addSubview:imageHolder];
    
    
}




- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    rect = CGRectInset(rect, rect.size.width/100*2, rect.size.height/100*2);
    [self choiceYourFeature:rect];
}


@end
