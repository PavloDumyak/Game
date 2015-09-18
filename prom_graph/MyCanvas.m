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


- (void)makeCircle:(CGRect)rect;
- (void)makeTriangle:(CGRect)rect;
- (void)makeEllipse: (CGRect) rect;
- (void)makeSquare: (CGRect) rect;
- (void)makeSinusoid: (CGRect) rect;
- (void)makeMeSmile: (CGRect) rect;
- (void)makeRhomb: (CGRect) rect;
- (void)makeTrapeze: (CGRect) rect;
- (void)makeYourChoise:(CGRect) rect;
- (void)makeNAngles: (CGRect) rect;
- (NSArray*)setPointsForNAngles:(CGRect)rect;
- (void) setColorOfPath;
- (void) setColorOfFill;
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

- (instancetype)initWithType:(MCFigureType)typeOfFigure :(MCColorChoise) colorOfStroke :(MCColorChoise) colorOfFill
{
    self = [super init];
    if (self)
    {
        self.selectedType = typeOfFigure;
        self.colorOfFigureStroke = colorOfStroke;
        self.colorOfFigureFill = colorOfFill;
        [self setBackgroundColor: [[UIColor clearColor] colorWithAlphaComponent: 0]];
    }
    return self;
}

- (instancetype)initWithType:(MCFigureType)typeOfFigure :(NSInteger) number :(MCColorChoise)colorOfStroke :(MCColorChoise) colorOfFill
{
    self = [super init];
    if (self)
    {
        self.selectedType = typeOfFigure;
        self.amount = number;
        self.colorOfFigureStroke = colorOfStroke;
        self.colorOfFigureFill = colorOfFill;
        [self setBackgroundColor: [[UIColor clearColor] colorWithAlphaComponent: 0]];
    }
   return self;
}


- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    rect = CGRectInset(rect, rect.size.width/100*3, rect.size.height/100*3);
    [self makeYourChoise:rect];
}

- (void)makeNAngles: (CGRect) rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *arr =[self setPointsForNAngles:rect];
    CGContextBeginPath (context);
    CGContextSetLineWidth(context,5);
    for(NSValue * point in arr)
    {
        CGPoint val = [point CGPointValue];
        if([arr indexOfObject:point]==0)
        {
            CGContextMoveToPoint (context, val.x, val.y);
        }
        else
        {
            CGContextSetRGBStrokeColor(context, 0, 255, 0, 1);
            CGContextAddLineToPoint (context, val.x, val.y);
        }
    }
    CGContextSetLineWidth(context, 2);
    CGContextClosePath(context);
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (NSArray*)setPointsForNAngles:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.90 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / self.amount;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < self.amount; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + curX,center.y + curY)]];}
    return result;
}

- (void) setColorOfPath
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (_colorOfFigureStroke) {
        case 0:
            CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
            break;
        case 1:
            CGContextSetStrokeColorWithColor(context, [[UIColor yellowColor] CGColor]);
            break;
        case 2:
            CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
            break;
        case 3:
            CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
            break;
        case 4:
            CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
            break;
        case 5:
            CGContextSetStrokeColorWithColor(context, [[UIColor brownColor] CGColor]);
            break;
        case 6:
            CGContextSetStrokeColorWithColor(context, [[UIColor purpleColor] CGColor]);
            break;
        case 7:
            CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
            break;
        case 8:
            CGContextSetStrokeColorWithColor(context, [[UIColor orangeColor] CGColor]);
            break;
        case 9:
            CGContextSetStrokeColorWithColor(context, [[UIColor cyanColor] CGColor]);
            break;
        case 10:
            CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
            break;
        default:
            break;
    }
}

- (void) setColorOfFill
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (_colorOfFigureFill) {
        case 0:
            CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
            break;
        case 1:
            CGContextSetFillColorWithColor(context, [[UIColor yellowColor] CGColor]);
            break;
        case 2:
            CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
            break;
        case 3:
            CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
            break;
        case 4:
            CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
            break;
        case 5:
            CGContextSetFillColorWithColor(context, [[UIColor brownColor] CGColor]);
            break;
        case 6:
            CGContextSetFillColorWithColor(context, [[UIColor purpleColor] CGColor]);
            break;
        case 7:
            CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
            break;
        case 8:
            CGContextSetFillColorWithColor(context, [[UIColor orangeColor] CGColor]);
            break;
        case 9:
            CGContextSetFillColorWithColor(context, [[UIColor cyanColor] CGColor]);
            break;
        case 10:
            CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
            break;
        default:
            break;
    }
}


- (void)makeYourChoise:(CGRect) rect
{
    switch (_selectedType) {
        case 0:
            [self makeTriangle:rect];
           
            break;
        case 1:
            [self makeCircle:rect];
            
            break;
        case 2:
            [self makeSquare:rect];
            break;
        case 3:
            [self makeRhomb:rect];
            break;
        case 4:
            [self makeNAngles:rect];
            break;
        case 5:
            [self makeEllipse:rect];
            break;
        case 6:
            [self makeTrapeze:rect];
            break;
        case 7:
            [self makeSinusoid:rect];
            break;
        case 8:
            [self makeMeSmile:rect];
            break;
        case 9:
            [self makeNAngles:rect];
            break;
        default:
            break;
    }
   
}

- (void)makeCircle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    
    CGRect circleRect = CGRectMake(3, 3, rect.size.width-6, rect.size.height-6);
    [self setColorOfPath];
    CGContextStrokeEllipseInRect(context, circleRect);
    [self setColorOfFill];
    CGContextFillEllipseInRect(context, circleRect);
}

- (void)makeTriangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGPoint points[6] = {CGPointMake(rect.size.width/2, 26), CGPointMake(rect.size.width-6, rect.size.height-6),
    CGPointMake(rect.size.width-6, rect.size.height-6), CGPointMake(6, rect.size.height-6),
    CGPointMake(6, rect.size.height-6), CGPointMake(rect.size.width/2, 26)};
    CGContextAddLines(context, points, 6);
    CGContextClosePath(context);
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);

}

- (void)makeEllipse: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGRect ellipseRect = CGRectMake(rect.size.width/4, 3, rect.size.width/2-6, rect.size.height-6);
    [self setColorOfPath];
    CGContextStrokeEllipseInRect(context, ellipseRect);
    [self setColorOfFill];
    CGContextFillEllipseInRect(context, ellipseRect);
}

- (void)makeSquare: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    int width = rect.size.width, hight = rect.size.height;
    CGContextBeginPath(context);
    CGPoint points[4] = {CGPointMake(rect.origin.x, rect.origin.y),
                         CGPointMake(width, rect.origin.y),
                         CGPointMake(width, hight),
                         CGPointMake(rect.origin.x, hight)};
    CGContextAddLines(context, points, 4);
    CGContextClosePath(context);
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (void)makeSinusoid: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    int y;
    for(int x=rect.origin.x; x < rect.size.width; x++)
    {
        y = ((rect.size.height/2) * sin(((x*4) % 360) * M_PI/180)) + rect.size.height/2;
        if (x <= rect.origin.x) CGContextMoveToPoint(context, x, y);
        else CGContextAddLineToPoint(context, x, y);
    }
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (void)makeMeSmile: (CGRect) rect
{
    CGFloat width = rect.size.width-rect.size.width/100*3;
    CGFloat height = rect.size.height-rect.size.height/100*3;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self setColorOfPath];
    CGContextSetLineWidth(context, 3.0);
    CGRect circleRect = CGRectMake(3, 3, width, height);
    CGContextStrokeEllipseInRect(context, circleRect);
    
    CGRect eye1Rect = CGRectMake(width/3, height/3, width/10, height/10);
    CGContextStrokeEllipseInRect(context, eye1Rect);
    CGRect ellipse1Rect = CGRectMake(width/3+width/100*4, height/3, width/40, height/10);
    CGContextFillEllipseInRect(context, ellipse1Rect);
    
    CGRect eye2Rect = CGRectMake((width/3)*2, height/3, width/10, height/10);
    CGContextStrokeEllipseInRect(context, eye2Rect);
    CGRect ellipse2Rect = CGRectMake((width/3)*2+width/100*4, height/3, width/40, height/10);
    CGContextFillEllipseInRect(context, ellipse2Rect);
    
    CGPoint bezierStart = {rect.size.width/3, rect.size.height-rect.size.height/3};
    CGPoint bezierEnd = {rect.size.width-rect.size.width/3, rect.size.height-rect.size.height/3};
    CGPoint bezierHelper1 = {rect.size.width/2, rect.size.height-rect.size.height/4};
    CGPoint bezierHelper2 = {rect.size.width/2, rect.size.height-rect.size.height/5};
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, bezierStart.x, bezierStart.y);
    CGContextAddCurveToPoint(context,
                             bezierHelper1.x, bezierHelper1.y,
                             bezierHelper2.x, bezierHelper2.y,
                             bezierEnd.x, bezierEnd.y);
    CGContextStrokePath(context);
}

- (void)makeRhomb: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    
    CGContextMoveToPoint(context, rect.size.width/2, 2);
    CGContextAddLineToPoint(context, rect.size.width-50, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
    CGContextAddLineToPoint(context, 50, rect.size.height/2);
    CGContextClosePath(context);
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (void)makeTrapeze: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    int width = rect.size.width, hight = rect.size.height;
    CGContextBeginPath(context);
    CGPoint points[4] = {CGPointMake(0+width/3, 0),
                         CGPointMake(width-width/3, 0),
                         CGPointMake(width, hight),
                         CGPointMake(0, hight)};
    CGContextAddLines(context, points, 4);
    CGContextClosePath(context);
    [self setColorOfFill];
    [self setColorOfPath];
    CGContextDrawPath(context, kCGPathEOFillStroke);
}






@end
