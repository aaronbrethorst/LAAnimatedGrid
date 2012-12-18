//
//  LAAnimatedView.h
//  LAAnimatedGridExample
//
//  Created by Mac2-Get-app on 18/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAAnimatedView : UIView

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)aImage;
- (void)setImage:(UIImage *)aImage;
- (void)setImageURL:(NSURL *)aURL placeholderImage:(UIImage *)aImage;

@end
