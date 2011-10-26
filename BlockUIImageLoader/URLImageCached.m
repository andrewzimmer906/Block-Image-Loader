//
//  URLImageCached.m
//  Tout
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Toutapp. All rights reserved.
//

#import "URLImageCached.h"
#import "URLImageLoadOperation.h"

@implementation URLImageCached

+(void)loadImageWithURL:(NSString*)url withLoadCompleteHandler:(URLImageLoadCompleteHandler)handler {
    URLImageLoadOperation *operation = [[URLImageLoadOperation alloc] init];
    [operation loadImageWithURL:url withLoadCompleteHandler:handler];
    [operation release];
}
@end
