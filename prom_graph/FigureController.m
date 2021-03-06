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
@property (nonatomic, strong) SpecialFeatures *currentFeature;
@property (nonatomic, assign) CGFloat originSize;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;
@property (nonatomic, strong) MyCanvas *contView;
@property (nonatomic, strong) MyCanvas *chosenView;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) MyCanvas *viewToCompare;
@property (nonatomic) NSInteger score;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timerForANewFigureEverySecond;
@property (nonatomic, strong) NSTimer *timerForFeatureAnimation;
@property (nonatomic, strong) NSTimer *timerForCreatinfFeature;
@property (nonatomic, strong) NSTimer *timerExplosive;
@property (nonatomic, strong) UIView *explosiveBackground;
@property (weak, nonatomic) IBOutlet UILabel *visualScore;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLable;
@property BOOL saveFlag;
@property (nonatomic, strong) NSMutableArray* shitArray;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat timeForANewAnimal;
@property (weak, nonatomic) IBOutlet UIImageView *myActiveBackground;

@end

@implementation FigureController
@synthesize shitArray=_shitArray;


- (void)viewWillDisappear:(BOOL)animated
{
    if(self.saveFlag == YES)
    {
   Saver *ob = [Saver sharedInstance];
   NSString *tmp = [NSString stringWithFormat:@"%li",(long)self.score];
  
        NSDictionary *result = [[NSUserDefaults standardUserDefaults] objectForKey:@"leader"];
        
        if (result == nil)
        {
            result = [[NSDictionary alloc] init];
        }
        
        NSMutableDictionary *mDict = [result mutableCopy];
    
        if (!ob.currentName|| ob.currentName.length == 0)
        {
            ob.currentName = @"<noname>";
        }

    [ob.myScoreRecords setValue:tmp forKey:ob.currentName];
    [mDict setObject:tmp forKey:ob.currentName];
    [[NSUserDefaults standardUserDefaults] setObject:mDict forKey:@"leader"];
    [[NSUserDefaults standardUserDefaults] setObject:ob.allNames forKey:@"name"];
    }
    self.saveFlag = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self createFigures];
    [self createFeature];
    self.distance = 1000000.0;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handlePan:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panRecognizer];
    [self startAllTimers];
    [self startAnimalTimer];
    
    
    self.gameOverLable.hidden = YES;
    self.point.hidden = YES;
    self.timeForANewAnimal = 2.0f;
    self.myActiveBackground.image = [UIImage imageNamed:@"1.jpg"];
    
   
    
   if ([[NSUserDefaults standardUserDefaults] integerForKey:@"gamestatus"]==1)
   {
       self.score =  [[NSUserDefaults standardUserDefaults] integerForKey:@"gamescore"];
       NSString *tmp = [NSString stringWithFormat:@"%li",(long)self.score];
       self.visualScore.text = tmp;
   }
   else
   {
       self.score = 0;
   }
    
}

- (void)startAnimalTimer
{
    self.timerForANewFigureEverySecond = [NSTimer scheduledTimerWithTimeInterval:self.timeForANewAnimal
                                                                          target:self
                                                                        selector:@selector(placeFigure)
                                                                        userInfo:nil
                                                                         repeats:YES];
}

- (void)startAllTimers
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(timerFire)
                                                userInfo:nil
                                                 repeats:YES];
    
    self.timerForFeatureAnimation = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                     target:self
                                                                   selector:@selector(FeaturetimerFire)
                                                                   userInfo:nil
                                                                    repeats:YES];
    
    self.timerForCreatinfFeature = [NSTimer scheduledTimerWithTimeInterval:20
                                                                    target:self
                                                                  selector:@selector(createFeature)
                                                                  userInfo:nil
                                                                   repeats:YES];
}


//music

- (void)playMusic:(NSInteger)choice
{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    UInt32 soundID;

    switch(choice)
    {
        case 0:
            soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"chpok", CFSTR("mp3"), NULL);
            break;
        case 1:
            soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"toxic", CFSTR("mp3"), NULL);
            break;
        case 2:
            soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"fail", CFSTR("mp3"), NULL);
            break;
    }
    
     AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
     AudioServicesPlaySystemSound(soundID);
}




//All timers

- (void)timerFire
{
    CGFloat distance = 20.0f;
    CGFloat viewHeight = self.view.frame.size.height - 30;
    CGFloat viewWidth = self.view.frame.size.width - 30;
    CACurrentMediaTime();
    __weak typeof(MyCanvas) *weakView = self.contView;
    [self moveAnimation:distance :viewHeight :viewWidth :weakView];
 
    
}


- (void)FeaturetimerFire
{
    //[self.currentFeature removeFromSuperview];
    //self.currentFeature = nil;
    CGFloat distance = 20.0f;
    CGFloat viewHeight = self.view.frame.size.height - 30;
    CGFloat viewWidth = self.view.frame.size.width - 30;
    CACurrentMediaTime();
   __weak typeof(SpecialFeatures) *weakView = self.currentFeature;
    [self featureAnimation:distance :viewHeight :viewWidth :weakView];
    
}




- (void)moveAnimation:(CGFloat)distance :(CGFloat)viewHeight :(CGFloat)viewWidth :(MyCanvas*) weakView
{
    if(self.shitArray.count==0)
    {
    [UIView animateWithDuration:0.1 animations:^{
        for (MyCanvas* figure in self.figures)
        {
            if (weakView == nil || (weakView && ![figure isEqual:weakView]))
            {
                CGPoint currentVector = figure.routeVector;
                if (figure.center.x + figure.frame.size.width / 2 >= viewWidth)
                {
                    currentVector = [self generateVector];
                    if (currentVector.x > 0)
                    {
                        currentVector.x = -currentVector.x;
                    }
                }
                else if (figure.center.x <= figure.frame.size.width / 2)
                {
                    currentVector = [self generateVector];
                    if(currentVector.x < 0)
                    {
                        currentVector.x *= -1;
                    }
                }
                
                if (figure.center.y + 30+figure.frame.size.height / 2 >= viewHeight)
                {
                    currentVector = [self generateVector];
                    if(currentVector.y > 0)
                    {
                        currentVector.y *= -1;
                    }
                }
                else if (figure.center.y <= 70+figure.frame.size.height / 2)
                {
                    currentVector = [self generateVector];
                    if(currentVector.y < 0)
                    {
                        currentVector.y *= -1;
                    }
                }
                figure.center = CGPointMake(figure.center.x +  currentVector.x, figure.center.y +  currentVector.y);
                figure.routeVector = currentVector;
            }
        }
    }];
    }
}




- (void)featureAnimation:(CGFloat)distance :(CGFloat)viewHeight :(CGFloat)viewWidth :(SpecialFeatures*) weakView
{
    
    [UIView animateWithDuration:0.1 animations:^{
        CGPoint currentVector = self.currentFeature.featureVector;
        
                       self.currentFeature.center = CGPointMake(self.currentFeature.center.x +  currentVector.x, self.currentFeature.center.y +  currentVector.y);
                self.currentFeature.featureVector = currentVector;
        if(self.currentFeature.center.x>400||self.currentFeature.center.y>400){
            self.currentFeature.center= self.view.center;
            
        }
    }];
    
}

- (void)changeBackground
{
    NSInteger currentBackgroundColor = rand()%4;
    [self.explosiveBackground removeFromSuperview];
    self.explosiveBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 600, 800)];
    self.explosiveBackground.backgroundColor = [UIColor blackColor];
    switch (currentBackgroundColor)
    {
        case 0:
            self.explosiveBackground.backgroundColor = [UIColor greenColor];
            break;
        case 1:
            self.explosiveBackground.backgroundColor = [UIColor blackColor];
            break;
        case 2:
            self.explosiveBackground.backgroundColor = [UIColor blueColor];
            break;
        case 3:
            self.explosiveBackground.backgroundColor = [UIColor yellowColor];
            break;
        case 4:
            self.explosiveBackground.backgroundColor = [UIColor whiteColor];
            break;
    }
    [self.view addSubview:self.explosiveBackground];
}


- (void)deleteAllAnimals
{
    [self playMusic:1];
    self.score = self.score + [self.figures count];
    self.timerExplosive = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                           target:self
                                                         selector:@selector(changeBackground)
                                                         userInfo:nil
                                                          repeats:YES];
    
    NSLog(@"ANIMALS  %lu", (unsigned long)[self.figures count]);
    for(int i = 0; i < [self.figures count]; i++)
    {
        [self.figures[i] removeFromSuperview];
    }
        [self.figures removeAllObjects];
    
    NSLog(@"%ld",(long)self.score);
    NSString *tmp = [NSString stringWithFormat:@"%li", (long)self.score];
    self.visualScore.text = tmp;
    NSLog(@"ANIMALS  %lu", (unsigned long)[self.figures count]);
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




- (void)changePanGesture:(UIPanGestureRecognizer*)paramsender
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


- (void)endPanGesture:(UIPanGestureRecognizer*)paramsender
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
        
        self.point.hidden = NO;
       
        self.point.center = self.chosenView.center;
        
        self.point.textColor = [UIColor redColor];
        [UIView animateWithDuration:2 animations:^{self.point.center = CGPointMake(self.chosenView.center.x, 0);}];
       // self.point.hidden = YES;
        NSString *tmp = [NSString stringWithFormat:@"%li",(long)self.score];
        self.visualScore.text = tmp;
        [self playMusic:0];
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
        [self playMusic:2];
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
    if(CGRectContainsPoint([self.currentFeature frame], location) && self.currentFeature.selectedType==0)
    {
          self.myActiveBackground.image = [UIImage imageNamed:@"2.jpg"];
       [self.timerForANewFigureEverySecond invalidate];
        self.timeForANewAnimal = 2;
        [self startAnimalTimer];
        [self deleteAllAnimals];
        [self.currentFeature removeFromSuperview];
        self.currentFeature = nil;
    }
    
    
    if(CGRectContainsPoint([self.currentFeature frame], location) && self.currentFeature.selectedType==1)
    {  self.myActiveBackground.image = [UIImage imageNamed:@"2.jpg"];
        [self.timerForANewFigureEverySecond invalidate];
        self.timeForANewAnimal = 2;
        [self startAnimalTimer];
        self.speed = 200.0f;
        [self.currentFeature removeFromSuperview];
        self.currentFeature = nil;
    }
    
    if(CGRectContainsPoint([self.currentFeature frame], location) && self.currentFeature.selectedType==2)
    {  self.myActiveBackground.image = [UIImage imageNamed:@"1.jpg"];
        [self.timerForANewFigureEverySecond invalidate];
        self.timeForANewAnimal = 2;
        [self startAnimalTimer];
        self.speed = 0.1f;
        [self.currentFeature removeFromSuperview];
        self.currentFeature = nil;
    }

    if(CGRectContainsPoint([self.currentFeature frame], location) && self.currentFeature.selectedType==3)
    {
      
        [self.timerForANewFigureEverySecond invalidate];// = YES;
        self.timeForANewAnimal = 1.0f;
        [self startAnimalTimer];
        [self.currentFeature removeFromSuperview];
        self.currentFeature = nil;
    }

    
    
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

// Creating figure and features

- (void)createFigures
{
    self.figures = [[NSMutableArray alloc] init];
    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
}

- (void)createFeature
{
    self.speed = 20.0f;
    [self.currentFeature removeFromSuperview];
    self.timeForANewAnimal = 2.0f;
    self.currentFeature = nil;
    int random = rand()%4;
    CGPoint tmpCords;
    
    if(random == 0)
   {   tmpCords = CGPointMake(rand()%320, rand()%400);
       self.currentFeature = [[SpecialFeatures alloc]initFeature:random:tmpCords];
       [self placeFeature:random];
   }
    
    if(random == 1)
    {   tmpCords = CGPointMake(rand()%320, rand()%400);
        self.currentFeature = [[SpecialFeatures alloc]initFeature:random:tmpCords];
        [self placeFeature:random];
    }
    
    if(random == 2)
    {   tmpCords = CGPointMake(rand()%320, rand()%400);
        self.currentFeature = [[SpecialFeatures alloc]initFeature:random:tmpCords];
        [self placeFeature:random];
    }
    
    if(random == 3)
    {   tmpCords = CGPointMake(rand()%320, rand()%400);
        self.currentFeature = [[SpecialFeatures alloc]initFeature:random:tmpCords];
        [self placeFeature:random];
    }
}




- (CGPoint)generateVector
{
    CGPoint currentVector;
   if(self.speed == 0)
   {
       self.speed = 20.0f;
   }
    CGFloat diffX = ((float)rand() / (float)RAND_MAX) * self.speed - self.speed/ 2.0f;
    CGFloat diffY = ((float)rand() / (float)RAND_MAX) * self.speed - self.speed/ 2.0f;
    currentVector = CGPointMake(diffX, diffY);
    return currentVector;
}


//Placing figure and feature
- (void)placeFeature:(NSInteger)type
{
    self.currentFeature.featureVector = [self generateVector];
      self.currentFeature.userInteractionEnabled = NO;
    [self.view addSubview:self.currentFeature];
    

}

- (void)placeFigure
{
    
    if(self.shitArray.count==0)
    {
        [self.timerExplosive invalidate];
        [self.explosiveBackground removeFromSuperview];
        NSInteger type = ((float)rand() / (float)RAND_MAX) * MCAnimalTypeCount;
        MyCanvas *ob;
    
    
        ob = [[MyCanvas alloc] initWithType: type];
        ob.routeVector = [self generateVector];
        self.currentFeature.featureVector = [self generateVector];

    
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
    [self.view addSubview:self.currentFeature];
    
    if([self.figures count]>80)
    {
        [self gameOver];
    }
}
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    Saver* ob  =[ Saver sharedInstance];
    if(buttonIndex == 0)
    {
    [ob setCurrentName:[[alertView textFieldAtIndex:0] text]];
        self.saveFlag = YES;
    }
    if(buttonIndex == 1)
    {
        self.saveFlag = NO;
    }
    
    [self performSegueWithIdentifier:@"goHome" sender:nil];
}

- (IBAction)endGame:(id)sender
{
    [self gameOver];
}
- (IBAction)stopMusicPlaying:(id)sender
{
    UIButton *theButton = (UIButton*)sender;
    NSInteger musicStatus =1;
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"musicstatus"]!=1)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:musicStatus forKey:@"musicstatus"];
        [theButton setImage:[UIImage imageNamed:@"playmusic.png"] forState:UIControlStateNormal];
        musicPlayer *ob = [musicPlayer sharedInstance];
        [ob stopMusic];
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"musicstatus"];
        [theButton setImage:[UIImage imageNamed:@"stopmusic.png"] forState:UIControlStateNormal];
        musicPlayer *ob = [musicPlayer sharedInstance];
        [ob playMusic];
    }
    
    
}
- (IBAction)gamePause:(id)sender
{
    int gameStatus = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:gameStatus forKey:@"gamestatus"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"gamescore"];
    [self performSegueWithIdentifier:@"goHome" sender:nil];
    
}

-(void)gameOver
{
    [self.timer invalidate];
    [self.timerForANewFigureEverySecond invalidate];
    [self.timerExplosive invalidate];
    [self.timerForCreatinfFeature invalidate];
    [self.timerForFeatureAnimation invalidate];
    self.view.userInteractionEnabled = NO;
    self.gameOverLable.hidden = NO;
    [self.view bringSubviewToFront:self.gameOverLable];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gamestatus"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you wanna save score?"
                                                    message:@"Write player's name"
                                                   delegate:self
                                          cancelButtonTitle:@"Yes"
                                          otherButtonTitles:@"No",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [self.view addSubview:alert];
    [alert show];
}
@end


