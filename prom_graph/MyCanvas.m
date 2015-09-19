//
//  MyCanvas.m
//  prom_graph
//
//  Created by adminaccount on 9/6/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "MyCanvas.h"

@interface MyCanvas ()
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger colorOfFigureFill;
@property (nonatomic, assign) NSInteger colorOfFigureStroke;
@property (nonatomic, assign) CGFloat originSize;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;
-(void)makeNewAnimal;
@end

@implementation MyCanvas
@synthesize selectedType  = _selectedType;
@synthesize amount = _amount;
@synthesize colorOfFigureStroke = _colorOfFigureStroke;
@synthesize colorOfFigureFill = _colorOfFigureFill;
@synthesize originSize = _originSize;
@synthesize firstX = _firstX;
@synthesize firstY = _firstY;
@synthesize routeVector=_routeVector;

- (instancetype)initWithType:(MCAnimalType)typeOfFigure
{
    self = [super init];
    if (self)
    {
        self.selectedType = typeOfFigure;
        [self setBackgroundColor: [[UIColor clearColor] colorWithAlphaComponent: 0]];
    }
    return self;
}






- (void)makeYourChoise:(CGRect) rect
{
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    UIImage *image;
    
    
    
    switch (self.selectedType) {
        case 0:
          image= [UIImage imageNamed:@"CatPinkImage.png"];
            break;
        case 1:
              image= [UIImage imageNamed:@"LamaImage.png"];
            
            break;
        case 2:
             image= [UIImage imageNamed:@"CatImage.png"];
            break;
        case 3:
              image= [UIImage imageNamed:@"EnotImage.png"];
            break;
        case 4:
            image= [UIImage imageNamed:@"CamelImage.png"];
            break;
        case 5:
            image= [UIImage imageNamed:@"CatCoolImage.png"];
            break;
        case 6:
            image= [UIImage imageNamed:@"DogLionImage.png"];
            break;
        case 7:
            image= [UIImage imageNamed:@"EagleImage.png"];
            break;
        case 8:
            image= [UIImage imageNamed:@"FrogImage.png"];
            break;
        case 9:
            image= [UIImage imageNamed:@"HaskiImage.png"];
            break;
        case 10:
            image= [UIImage imageNamed:@"MouseImage.png"];
            break;
        case 11:
            image= [UIImage imageNamed:@"PandaImage.png"];
            break;
       
        default:
            break;
    }
   imageHolder.image = image;
   [self addSubview:imageHolder];
}


-(void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    rect = CGRectInset(rect, rect.size.width/100*2, rect.size.height/100*2);
    [self makeYourChoise:rect];
}


@end
