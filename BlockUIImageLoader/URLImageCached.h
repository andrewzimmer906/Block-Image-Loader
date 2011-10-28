//
//  URLImageCached.h
//  Andrew Zimmer
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
//  This class pulls a UIImage from a remote url and return's the result using a _BLOCK.
//  We also cache the images for future use.
//  

#import <Foundation/Foundation.h>
#import "URLImageCacheConstants.h"

@interface URLImageCached : NSObject

/* 
   Call this method to initiate loading a UIImage from a url. 
   The handler block is called when the image finishes loading.
 
   RETURNS: Yes if internet access is available. NO if it is not.
 */
+(BOOL)loadImageWithURL:(NSString*)url withLoadCompleteHandler:(URLImageLoadCompleteHandler)handler;

/* 
  Call this method to initiate loading a UIImage from a url.  
  The progress block is called when the image makes loading progress, (0.0 - 1.0)  
  The handler block is called when the image finishes loading.
 
  RETURNS: Yes if internet access is available. NO if it is not.
 */
+(BOOL)loadImageWithURL:(NSString*)url withLoadProgressHandler:(URLImageLoadProgressHandler)progressHandler withLoadCompleteHandler:(URLImageLoadCompleteHandler)completeHandler;


/* When called flushes the image cache completly. This also happens automatically when the cache gets too
   full as set in URLImageCacheConstants.
 */
+(void)flushCache;

@end
