//
//  SpecialFeatures.h
//  prom_graph
//
//  Created by Pavlo Dumyak on 9/21/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialFeatures : UIView

typedef NS_ENUM(NSInteger, SCFeatureType)
{
    SCFeatureBomb
};

-(instancetype)initFeature:(SCFeatureType)typeOfFeature;
-(void)choiceYourFeature:(CGRect)rect;
@property (nonatomic, assign) SCFeatureType selectedType;
@property (nonatomic, assign) CGPoint featureVector;
@end
