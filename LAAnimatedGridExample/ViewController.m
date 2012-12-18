//
//  ViewController.m
//  LAAnimatedGridExample
//
//  Created by Mac2-Get-app on 18/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//

#import "ViewController.h"
#import "LAAnimatedGrid.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Array of images
    NSMutableArray *arrImages = [NSMutableArray array];
    for (int i=1; i<11; i++)
    {
        [arrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"ios%d.jpeg", i]]];
    }
    
    
    // LAAnimatedGrid
    LAAnimatedGrid *laag = [[LAAnimatedGrid alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    laag.backgroundColor = [UIColor blackColor];
    [laag setArrImages:arrImages];
    [laag setLaagOrientation:LAAGOrientationVertical];
    
    [self.view addSubview:laag];
    
#if !__has_feature(objc_arc)
    [laag release];
#endif
    
    // LAAnimatedGrid
    /*laag = [[LAAnimatedGrid alloc] initWithFrame:CGRectMake(10, 150, 300, 200)];
    laag.backgroundColor = [UIColor blackColor];
    [laag setArrImages:arrImages];
    
    [self.view addSubview:laag];
    
#if !__has_feature(objc_arc)
    [laag release];
#endif
    
    // LAAnimatedGrid
    laag = [[LAAnimatedGrid alloc] initWithFrame:CGRectMake(10, 300, 300, 200)];
    laag.backgroundColor = [UIColor blackColor];
    [laag setArrImages:arrImages];
    
    [self.view addSubview:laag];
    
#if !__has_feature(objc_arc)
    [laag release];
#endif*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
