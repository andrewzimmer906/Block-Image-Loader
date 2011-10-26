//
//  URLImageCached.m
//  Tout
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Toutapp. All rights reserved.
//

#import "URLImageCached.h"
#import "URLImageLoadOperation.h"

#import <sys/socket.h>
#import <netinet/in.h>

#import <SystemConfiguration/SystemConfiguration.h>

/*!
 @typedef SCNetworkReachabilityRef
 @discussion This is the handle to a network address or name.
 */
typedef const struct __SCNetworkReachability * SCNetworkReachabilityRef;

/* Private Class Methods */
@interface URLImageCached(Private)
    +(BOOL)hasConnectivity;
@end

@implementation URLImageCached

+(BOOL)loadImageWithURL:(NSString*)url withLoadCompleteHandler:(URLImageLoadCompleteHandler)handler {
    BOOL connectivity = [URLImageCached hasConnectivity];
    if(connectivity) {
        URLImageLoadOperation *operation = [[URLImageLoadOperation alloc] init];
        [operation loadImageWithURL:url withLoadProgressHandler:nil withLoadCompleteHandler:handler];
        [operation release];
    }
    return connectivity;
}

+(BOOL)loadImageWithURL:(NSString*)url withLoadProgressHandler:(URLImageLoadProgressHandler)progressHandler withLoadCompleteHandler:(URLImageLoadCompleteHandler)completeHandler {
    BOOL connectivity = [URLImageCached hasConnectivity];
    if(connectivity) {
        URLImageLoadOperation *operation = [[URLImageLoadOperation alloc] init];
        [operation loadImageWithURL:url withLoadProgressHandler:progressHandler withLoadCompleteHandler:completeHandler];
        [operation release];
    }
    return connectivity;
}

-(void)flushCache {
    //TODO
}
@end

@implementation URLImageCached(Private)

/* Connectivity testing code pulled from Apple's Reachability Example: http://developer.apple.com/library/ios/#samplecode/Reachability
 */
+(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    
    return reachability != NULL;
}

@end
