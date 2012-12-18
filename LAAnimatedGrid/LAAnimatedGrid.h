//
//  LAAnimatedGrid.h
//  LAAnimatedGridExample
//
//  Created by Mac2-Get-app on 18/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//

#import <UIKit/UIKit.h>

//                  HORIZONTAL
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

//                  VERTICAL
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

typedef enum
{
    LAAGOrientationHorizontal = 1,
    LAAGOrientationVertical
}LAAGOrientation;

@interface LAAnimatedGrid : UIView

// laagOrientation   -> Is used to perform the view in horizontal or vertical (Default: horizontal)
// arrImage          -> Image array (could be UIImages or NSURLs)
// placeholderImage  -> The placeholder image to show when the images are URLs

@property (nonatomic, assign) LAAGOrientation laagOrientation;
@property (nonatomic, retain) NSMutableArray *arrImages;
@property (nonatomic, retain) UIImage *placeholderImage;
@property (nonatomic, assign) int margin;

@end
