//
//  FigureController.m
//  prom_graph
//
//  Created by adminaccount on 9/11/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "FigureController.h"
#import "MyCanvas.h"


static NSInteger const kNumberOfFigures = 10;

@interface FigureController ()

@property (nonatomic, strong)  NSMutableArray *figures;
//@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, assign) CGFloat originSize;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;
@property (nonatomic, strong) MyCanvas *contView;
@property (nonatomic, strong) MyCanvas *chosenView;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) MyCanvas *viewToCompare;
@property (nonatomic) int score;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FigureController



-(void)viewWillDisappear:(BOOL)animated
{
    Saver *ob = [Saver sharedInstance];
    ob.result = self.score;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createFigures];
    self.distance = 1000000.0;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                  selector:@selector(timerFire)
                                                  userInfo:nil
                                                   repeats:YES];
    self.score=0;
}



- (void)timerFire
{
    CGFloat distance = 20.0f;
    CGFloat viewHeight = self.view.frame.size.height - 30;
    CGFloat viewWidth = self.view.frame.size.width - 30;
    CACurrentMediaTime();
    __weak typeof(MyCanvas) *weakView = self.contView;
    [self moveAnimation:distance :viewHeight :viewWidth :weakView];
}




-(void)moveAnimation:(CGFloat)distance :(CGFloat)viewHeight :(CGFloat)viewWidth :(MyCanvas*) weakView
{
    [UIView animateWithDuration:0.1 animations:^{
        for (MyCanvas* figure in self.figures)
        {
            if (weakView == nil || (weakView && ![figure isEqual:weakView]))
            {
                CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
                CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
            
                if(figure.center.x >= viewWidth && diffX > 0)
                {
                        diffX *= -1;
                }
                if(figure.center.x <= 50 && diffX < 0)
                {
                    diffX *= -1;
                }
                if(figure.center.y >= viewHeight && diffY > 0)
                {
                    diffY *= -1;
                }
                if(figure.center.y <= 100 && diffY < 0)
                {
                    diffY *= -1;
                }
                figure.center = CGPointMake(figure.center.x + diffX, figure.center.y + diffY);
            }
        }
    }];
}



- (void)handlePan:(UIPanGestureRecognizer*)paramsender
{
    if (paramsender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [paramsender locationInView:paramsender.view];
        for(int i=0; i<self.figures.count;i++)
        {
            if(CGRectContainsPoint([self.figures[i] frame], location))
            {
                self.contView = self.figures[i];
                self.originSize  = self.contView.frame.size.width;
                break;
            }
        }
    }
    
    if (paramsender.state == UIGestureRecognizerStateChanged)
    {
        [self changePanGesture:paramsender];
    }
    
    if( paramsender.state == UIGestureRecognizerStateEnded)
    {
        [self endPanGesture:paramsender];
    }
    
    if( paramsender.state == UIGestureRecognizerStateCancelled)
    {
        self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.contView.layer.shadowOpacity = 0.5f;
        [self makeNill];
    }
    
    if(paramsender.state == UIGestureRecognizerStateFailed)
    {
        [self makeNill];
    }
}




-(void)changePanGesture:(UIPanGestureRecognizer*)paramsender
{
    CGPoint center = self.contView.center;
    CGPoint translation = [paramsender translationInView: self.view];
    center.x += translation.x;
    center.y += translation.y;
    self.contView.center = center;
    [paramsender setTranslation:CGPointZero inView:self.view];
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.contView.layer.shadowOpacity = 0.5f;
    
    for(int i = 0; i < self.figures.count; i++)
    {
        if (![self.figures[i] isEqual:self.contView]) {
            self.viewToCompare = self.figures[i];
            self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.viewToCompare.layer.shadowOpacity = 0.0f;
        }
        
        if(CGRectIntersectsRect(self.contView.frame, [self.figures[i] frame]) && self.contView != self.figures[i])
        {
            self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
            self.viewToCompare.layer.shadowOpacity = 0.5f;
        }
    }
}


-(void)endPanGesture:(UIPanGestureRecognizer*)paramsender
{
    [UIView animateWithDuration:0.1 animations:^{ self.contView.transform = CGAffineTransformIdentity;}];
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.contView.layer.shadowOpacity = 0.0f;
    for(int i=0; i<self.figures.count;i++)
    {
        if(CGRectIntersectsRect(self.contView.frame, [self.figures[i] frame]) && self.contView != self.figures[i])
        {
            self.viewToCompare = self.figures[i];
            self.viewToCompare.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.viewToCompare.layer.shadowOpacity = 0.0f;
            self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.contView.layer.shadowOpacity = 0.0f;
            
            CGPoint center = self.contView.center;
            CGPoint currentFigureCenter = self.viewToCompare.center;
            
            CGFloat xDist = (center.x - currentFigureCenter.x);
            CGFloat yDist = (center.y - currentFigureCenter.y);
            CGFloat currentDistance = sqrt((xDist * xDist) + (yDist * yDist));
            if(self.distance > currentDistance)
            {
                self.distance = currentDistance;
                self.chosenView = self.figures[i];
            }
        }
    }
    
    if ([self.contView selectedType] == [self.chosenView selectedType]&& self.chosenView!=nil && self.contView!=nil)
    {
        [self.contView removeFromSuperview];
        [self.chosenView removeFromSuperview];
        self.score++;
        NSLog(@"%i",self.score);
        for(int j = 0;j < self.figures.count; j++)
        {
            if ([self.figures[j] isEqual: self.contView] || [self.figures[j] isEqual: self.chosenView])
            {
                [self.figures removeObjectAtIndex:j];
            }
        }
        [self makeNill];
        
    }
    
    else if ([self.contView selectedType] != [self.chosenView selectedType] && self.chosenView!=nil && self.contView!=nil)
    {
        [self placeFigure];
        self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.contView.layer.shadowOpacity = 0.0f;
        
        self.chosenView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.chosenView.layer.shadowOpacity = 0.0f;
        
        [self makeNill];
    }
    [self makeNill];
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint location = [touches.anyObject locationInView:self.view];
    for(int i = 0; i < self.figures.count; i++)
    {
        if(CGRectContainsPoint([self.figures[i] frame], location))
        {
            self.contView = self.figures[i];
            [UIView animateWithDuration:0.1
                             animations:^{
                self.contView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
            }];
        }
    }
    
    [self.view bringSubviewToFront:self.contView];
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.contView.layer.shadowOpacity = 0.5f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    self.contView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.contView.layer.shadowOpacity = 0.0f;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.contView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.contView = nil;
        
    }];
}

- (void) makeNill
{
    self.contView = nil;
    self.chosenView = nil;
    self.viewToCompare = nil;
    self.distance = 1000000.0;
}

- (void)createFigures
{
    self.figures = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
}

- (void)placeFigure
{

        NSInteger type = ((float)rand() / (float)RAND_MAX) * MCFigureTypeCount;
        NSInteger colorStroke = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
        NSInteger colorFill = ((float)rand() / (float)RAND_MAX) * MCColorChoiseCount;
        MyCanvas *ob;
    
        if (type!=4 && type!=9)
        {
            ob = [[MyCanvas alloc] initWithType: type:colorStroke: colorFill];
        }
        if (type == 4)
        {
            ob = [[MyCanvas alloc] initWithType: MCFigureTypeNAngles: 6: colorStroke: colorFill];
        }
        if (type == 9)
        {
            ob = [[MyCanvas alloc] initWithType:MCFigureTypeNAngles: 12: colorStroke: colorFill];
        }
        CGSize size = self.view.frame.size;
        CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
        
        CGRect figureFrame = CGRectZero;
        for (int j = 0; j < 100; ++j)
        {
            figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                     ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                     figureSize, figureSize);
            
            
            BOOL intersects = NO;
            for (MyCanvas* figure in self.figures)
            {
                if (CGRectIntersectsRect(figureFrame, [figure frame]))
                {
                    intersects = YES;
                    break;
                }
            }
            
            if (!intersects)
            {
                break;
            }
        }
        ob.frame = figureFrame;
    ob.userInteractionEnabled = NO;
        [self.figures addObject:ob];
        [self.view addSubview:ob];
}

@end


