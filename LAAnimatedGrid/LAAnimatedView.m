//
//  LAAnimatedView.m
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

#import "LAAnimatedView.h"
#import "UIImageView+AFNetworking.h"

@interface LAAnimatedView () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imgView;
    UIImage *_image;
}

@end

@implementation LAAnimatedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)aImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
#if !__has_feature(objc_arc)
        _image = [aImage retain];
#else
        _image = aImage;
#endif
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_scrollView release];
    [_imgView release];
    [_image release];
    
    [super dealloc];
}
#endif

#pragma mark - Drawing

// Drawing code
- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor redColor];
    
    // UIImageView setup
    _imgView                        = [[UIImageView alloc] initWithImage:_image];
    _imgView.autoresizingMask       = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    _imgView.frame                  = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=_image.size};
    
    
    // UIScrollView setup
    CGRect frame                                    = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    _scrollView                                     = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.pagingEnabled                       = NO;
    _scrollView.showsHorizontalScrollIndicator      = NO;
    _scrollView.showsVerticalScrollIndicator        = NO;
    _scrollView.scrollsToTop                        = NO;
    _scrollView.clipsToBounds                       = YES;
    _scrollView.delegate                            = self;
    _scrollView.userInteractionEnabled              = NO;
    _scrollView.autoresizingMask                    = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.backgroundColor                     = [UIColor clearColor];
    _scrollView.contentSize                         = _image.size;
    
    // Adding subviews
    [_scrollView addSubview:_imgView];
    [self addSubview:_scrollView];
    
    // Image
    //[self adjustImage];
}

#pragma mark - Functions

- (void)setImage:(UIImage *)aImage
{
#if !__has_feature(objc_arc)
    [_image release];
    _image = [aImage retain];
#else
    _image = aImage;
#endif
    
    [self adjustImage];
}

- (void)setImageURL:(NSURL *)aURL placeholderImage:(UIImage *)aImage
{
#if !__has_feature(objc_arc)
    [_image release];
    _image = [aImage retain];
#else
    _image = aImage;
#endif
    
    [_imgView setImageWithURL:aURL
             placeholderImage:_image
                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                      {
                          // adjust image when its assigned
                          [self adjustImage];
                      }
                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                      {
                          // now do nothing 
                      }
     ];
}

- (void) adjustImage
{
    if ([self superview])
    {
        // set the image in the UIImageView
        _imgView.image = _image;
        _imgView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=_image.size};
        
        
        // ContentSize and ZoomScale
        _scrollView.contentSize         = _image.size;
        CGRect scrollViewFrame          = _scrollView.frame;
        CGFloat scaleWidth              = scrollViewFrame.size.width / _scrollView.contentSize.width;
        CGFloat scaleHeight             = scrollViewFrame.size.height / _scrollView.contentSize.height;
        CGFloat minScale                = MIN(scaleWidth, scaleHeight);
        _scrollView.minimumZoomScale    = minScale;
        _scrollView.maximumZoomScale    = 1.0f;
        _scrollView.zoomScale           = minScale;
        
        
        // center the content
        [self centerScrollViewContents];
    }
}

- (void)centerScrollViewContents
{
    CGSize boundsSize       = _scrollView.bounds.size;
    CGRect contentsFrame    = _imgView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) 
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    else 
        contentsFrame.origin.x = 0.0f;
    
    if (contentsFrame.size.height < boundsSize.height) 
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    else 
        contentsFrame.origin.y = 0.0f;
    
    _imgView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

@end
