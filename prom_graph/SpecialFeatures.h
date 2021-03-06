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
    SCFeatureBomb,
    SCFeatureFaster,
    SCFeatureSlower,
    SCFeatureAddNewAnimalFastly
};

- (instancetype)initFeature:(SCFeatureType)typeOfFeature :(CGPoint)xy;
- (void)choiceYourFeature:(CGRect)rect;
- (void)createPieceOfShit:(CGRect)rect;
@property (nonatomic, assign) SCFeatureType selectedType;
@property (nonatomic, assign) CGPoint featureVector;
@property (nonatomic, assign) CGRect currentRect;
@property (nonatomic, assign) CGPoint coords;
@end
