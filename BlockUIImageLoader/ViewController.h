//
//  ViewController.h
//  BlockUIImageLoader
//
//  Created by Andrew Zimmer on 10/26/11.
//  Copyright (c) 2011 Modea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSString *curLoadingURL_;
    __block id blockSelf_;
}

@property(nonatomic, retain) __block IBOutlet UIImageView *imageView;
@property(nonatomic, retain) __block IBOutlet UIProgressView *progressView;

-(IBAction)loadImage1:(id)sender;
-(IBAction)loadImage2:(id)sender;
-(IBAction)loadImage3:(id)sender;
-(IBAction)clearImageCache:(id)sender;

@end
