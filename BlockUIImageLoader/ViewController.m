//
//  ViewController.m
//  BlockUIImageLoader
//
//  Created by Andrew Zimmer on 10/26/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import "ViewController.h"
#import "URLImageCached.h"

#define IMAGE_1_URL @"http://farm7.static.flickr.com/6159/6263221527_6f629d6df7_b.jpg"
#define IMAGE_2_URL @"http://farm4.static.flickr.com/3324/5709658575_185b3a341f_b.jpg"
#define IMAGE_3_URL @"http://farm7.static.flickr.com/6060/5904339697_9ea19a7ae1_z.jpg"

@interface ViewController(Private)
    -(URLImageLoadCompleteHandler)setImageBlock;
    -(URLImageLoadProgressHandler)setProgressBlock;
@end

@implementation ViewController
@synthesize imageView, progressView;

#pragma mark - Memory Management
-(void)dealloc {
    [imageView release];
    imageView = nil;
    
    [progressView release];
    progressView = nil;
    
    blockSelf_ = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    blockSelf_ = self;
    progressView.hidden = YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];

    [imageView release];
    imageView = nil;
    
    [progressView release];
    progressView = nil;
}

#pragma mark - Events
-(IBAction)loadImage1:(id)sender {
    curLoadingURL_ = IMAGE_1_URL;
    progressView.hidden = NO;
    progressView.progress = 0.0f;
    
    if([URLImageCached loadImageWithURL:IMAGE_1_URL withLoadProgressHandler:[self setProgressBlock]
                       withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_1_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

-(IBAction)loadImage2:(id)sender {
    curLoadingURL_ = IMAGE_2_URL;
    progressView.hidden = NO;
    progressView.progress = 0.0f;

    if([URLImageCached loadImageWithURL:IMAGE_2_URL withLoadProgressHandler:[self setProgressBlock]
                withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_2_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

-(IBAction)loadImage3:(id)sender {
    curLoadingURL_ = IMAGE_3_URL;
    progressView.hidden = YES;
    
    if([URLImageCached loadImageWithURL:IMAGE_3_URL withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_3_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

@end

@implementation ViewController(Private)

-(URLImageLoadProgressHandler)setProgressBlock {
    return [[^void(float progress, NSString *url) {
        if(blockSelf_ != nil && [url isEqualToString:curLoadingURL_]) {
            progressView.progress = progress;
        }
    } copy] autorelease];
}


-(URLImageLoadCompleteHandler)setImageBlock {
    return [[^void(UIImage *loadedImage, NSString *url) {
        if(blockSelf_ != nil && [url isEqualToString:curLoadingURL_]) {
            imageView.image = loadedImage;
            progressView.hidden = YES;
        }
    } copy] autorelease];
}
@end
