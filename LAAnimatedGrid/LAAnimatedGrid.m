//
//  LAAnimatedGrid.m
//  LAAnimatedGridExample
//
//  Created by Luis Ascorbe on 18/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//
/*
 
 LAAnimatedGrid is available under the MIT license.
 
 Copyright © 2012 Luis Ascorbe.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "LAAnimatedGrid.h"
#import "LAAnimatedView.h"

#define MAX_RANDOM_SEC  5
#define MARGIN          5

#pragma mark -

@interface LAAnimatedGrid ()
{
    LAAnimatedView *view1;
    LAAnimatedView *view2;
    LAAnimatedView *view3;
    LAAnimatedView *view4;
    LAAnimatedView *view5;
    LAAnimatedView *view6;
    
    NSTimer *imageTimer;
    NSArray *arrViews;
}

@end

#pragma mark -

@implementation LAAnimatedGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _laagOrientation = LAAGOrientationHorizontal;
        _margin = MARGIN;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)dealloc
{
    [imageTimer invalidate];
    imageTimer = nil;
    
#if !__has_feature(objc_arc)
    [_arrImages release];
    [_placeholderImage release];
    [arrViews release];
    
    [super dealloc];
#endif
}


#pragma mark - Drawing

// Drawing code
- (void)drawRect:(CGRect)rect
{
    switch (_laagOrientation)
    {
        case LAAGOrientationHorizontal:
        {
            [self setupHorizontal];
        }
            break;
            
        case LAAGOrientationVertical:
        {
            [self setupVertical];
        }
            break;
            
        default:
        {
            [self setupHorizontal];
        }
            break;
    }
    
    [self setImages];
}

#pragma mark - Functions

//                   HORIZONTAL
//      -------------------------------------
//      |        |                |         |
//      |    1   |                |    3    |
//      |        |                |         |
//      |--------|       2        |---------|
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      |   4    |----------------|    6    |
//      |        |                |         |
//      |        |       5        |         |
//      |        |                |         |
//      -------------------------------------

- (void)setupHorizontal
{
    CGRect mainFrame = self.frame;
    mainFrame.size.width -= _margin;
    mainFrame.size.height -= _margin;
    
    // First Line
    view1 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, _margin, (mainFrame.size.width/4)-_margin, (mainFrame.size.height/3)-_margin)];
    view2 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/4)+_margin, _margin, (mainFrame.size.width/4)*2-_margin, (mainFrame.size.height/3)*2-_margin)];
    view3 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/4)*3+_margin, _margin, mainFrame.size.width/4-_margin, mainFrame.size.height/3-_margin)];
    
    NSLog(@"%f", (mainFrame.size.width/4));
    
    // Second Line
    view4 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, (mainFrame.size.height/3)+_margin, mainFrame.size.width/4-_margin, (mainFrame.size.height/3)*2-_margin)];
    view5 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/4+_margin, (mainFrame.size.height/3)*2+_margin, (mainFrame.size.width/4)*2-_margin, mainFrame.size.height/3-_margin)];
    view6 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/4*3+_margin, mainFrame.size.height/3+_margin, mainFrame.size.width/4-_margin, (mainFrame.size.height/3)*2-_margin)];
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:view5];
    [self addSubview:view6];
    
#if !__has_feature(objc_arc)
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    [view5 release];
    [view6 release];
#endif
}

//                VERTICAL
//      ---------------------------
//      |                 |       |
//      |        1        |   2   |
//      |                 |       |
//      |-------------------------|
//      |        |                |
//      |        |                |
//      |        |                |
//      |   3    |       4        |
//      |        |                |
//      |        |                |
//      |        |                |
//      |-------------------------|
//      |                 |       |
//      |        5        |   6   |
//      |                 |       |
//      ---------------------------

- (void)setupVertical
{
    CGRect mainFrame = self.frame;
    mainFrame.size.width -= _margin;
    mainFrame.size.height -= _margin;
    
    // First Line
    view1 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, _margin, (mainFrame.size.width/3)*2-_margin, mainFrame.size.height/4-_margin)];
    view2 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/3)*2+_margin, _margin, mainFrame.size.width/3-_margin, mainFrame.size.width/4-_margin)];
    
    // Second Line
    view3 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, mainFrame.size.height/4+_margin, mainFrame.size.width/3-_margin, (mainFrame.size.height/4)*2-_margin)];
    view4 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/3+_margin, mainFrame.size.height/4+_margin, (mainFrame.size.width/3)*2-_margin, (mainFrame.size.height/4)*2-_margin)];
    
    // Third Line
    view5 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, (mainFrame.size.height/4)*3+_margin, (mainFrame.size.width/3)*2-_margin, mainFrame.size.height/4-_margin)];
    view6 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/3)*2+_margin, (mainFrame.size.height/4)*3+_margin, mainFrame.size.width/3-_margin, mainFrame.size.height/4-_margin)];
    
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:view5];
    [self addSubview:view6];
    
#if !__has_feature(objc_arc)
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    [view5 release];
    [view6 release];
#endif
}

- (void)setImages
{
    for (LAAnimatedView *laaView in [self subviews])
    {
        int randomNum   = [self giveRandomNumImage];
        id obj          = [_arrImages objectAtIndex:randomNum];
        if ([obj isKindOfClass:[UIImage class]])
        {
            [laaView setImage:obj];
        }
        else if ([obj isKindOfClass:[NSURL class]])
        {
            [laaView setImageURL:obj placeholderImage:_placeholderImage];
        }
        else
        {
            NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d)", randomNum);
        }
    }
    
    imageTimer = [NSTimer scheduledTimerWithTimeInterval:[self giveRandomSeconds] target:self selector:@selector(randomizeImage) userInfo:nil repeats:NO];
}

- (void)randomizeImage
{
    LAAnimatedView *laaView = [[self subviews] objectAtIndex:[self giveRandomNumView]];
    int randomNum           = [self giveRandomNumImage];
    id obj                  = [_arrImages objectAtIndex:randomNum];
    if ([obj isKindOfClass:[UIImage class]])
    {
        [laaView setImage:obj];
    }
    else if ([obj isKindOfClass:[NSURL class]])
    {
        [laaView setImageURL:obj placeholderImage:_placeholderImage];
    }
    else
    {
        NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d)", randomNum);
    }
    
    imageTimer = [NSTimer scheduledTimerWithTimeInterval:[self giveRandomSeconds] target:self selector:@selector(randomizeImage) userInfo:nil repeats:NO];
}

- (int)giveRandomNumImage
{
    return arc4random() % [_arrImages count];
}

- (int)giveRandomSeconds
{
    return arc4random() % MAX_RANDOM_SEC;
}

- (int)giveRandomNumView
{
    return arc4random() % [[self subviews] count];
}

@end

/*
 
 // view1
 int randomNum   = [self giveRandomNumber];
 id obj          = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view1 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view1 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d)", randomNum);
 }
 
 // view2
 randomNum   = [self giveRandomNumber];
 obj         = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view2 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view2 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d of the arrImage)", randomNum);
 }
 
 // view3
 randomNum   = [self giveRandomNumber];
 obj         = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view3 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view3 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d of the arrImage)", randomNum);
 }
 
 // view4
 randomNum   = [self giveRandomNumber];
 obj         = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view4 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view4 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d of the arrImage)", randomNum);
 }
 
 // view5
 randomNum   = [self giveRandomNumber];
 obj         = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view5 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view5 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d of the arrImage)", randomNum);
 }
 
 // view6
 randomNum   = [self giveRandomNumber];
 obj         = [_arrImages objectAtIndex:randomNum];
 if ([obj isKindOfClass:[UIImage class]])
 {
 [view6 setImage:obj];
 }
 else if ([obj isKindOfClass:[NSURL class]])
 {
 [view6 setImageURL:obj placeholderImage:_placeholderImage];
 }
 else
 {
 NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d of the arrImages)", randomNum);
 }

 */






