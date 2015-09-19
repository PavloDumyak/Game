//
//  MyCanvas.h
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCAnimalType)
{
    MCAnimalTypePinkCat,
    MCAnimalTypeLama,
    MCAnimalTypeDumbassCat,
    MCAnimalTypeEnot,
    MCAnimalTypeCamel,
    MCAnimalTypeCatCool,
    MCAnimalTypeDogLion,
    MCAnimalTypeEagle,
    MCAnimalTypeFrog,
    MCAnimalTypeHaski,
    MCAnimalTypeMouse,
    MCAnimalTypePanda,
    MCAnimalTypeCount
};



@interface MyCanvas : UIView
@property (nonatomic, assign) MCAnimalType selectedType;
- (instancetype)initWithType:(MCAnimalType)typeOfFigure;;
@property (nonatomic) CGPoint routeVector;
@end
