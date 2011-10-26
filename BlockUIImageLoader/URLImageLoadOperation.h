//
//  URLImageLoadOperation.h
//  Tout
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Toutapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLImageCacheConstants.h"

@interface URLImageLoadOperation : NSObject {
    URLImageLoadCompleteHandler loadCompleteHandler;
    NSString *loadUrl;
    NSMutableData *receivedData;
}

-(void)loadImageWithURL:(NSString*)url withLoadCompleteHandler:(URLImageLoadCompleteHandler)handler;
@end
