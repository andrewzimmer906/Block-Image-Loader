//
//  URLImageLoadOperation.h
//  Andrew Zimmer
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
//  Handles the actual image loading bit.  Oh Yeah!
//  Uses a static NSMutableDictionary to do the image cache.
//

#import <Foundation/Foundation.h>
#import "URLImageCacheConstants.h"

@interface URLImageLoadOperation : NSObject {
    URLImageLoadCompleteHandler loadCompleteHandler;
    URLImageLoadProgressHandler loadProgressHandler;
    NSString *loadUrl;
    NSMutableData *receivedData;
    long long expectedContentLength;
}

/* Load that image! */
-(void)loadImageWithURL:(NSString*)url withLoadProgressHandler:(URLImageLoadProgressHandler)progressHandler withLoadCompleteHandler:(URLImageLoadCompleteHandler)completeHandler;

/* Clear the image cache */
-(void)clearCache;
@end
