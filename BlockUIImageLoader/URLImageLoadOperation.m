//
//  URLImageLoadOperation.m
//  Tout
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Toutapp. All rights reserved.
//

#import "URLImageLoadOperation.h"



@implementation URLImageLoadOperation

// method to return a static cache reference (ie, no need for an init method)
-(NSMutableDictionary*)cache
{
	static NSMutableDictionary* _cache = nil;
	
	if( !_cache )
		_cache = [[NSMutableDictionary alloc] initWithCapacity:MAX_CACHED_IMAGES];
    
	assert(_cache);
	return _cache;
}

-(void)dealloc {
    [loadCompleteHandler release];
    [loadUrl release];
    [super dealloc];
}

-(void)loadImageWithURL:(NSString*)url withLoadCompleteHandler:(URLImageLoadCompleteHandler)handler {
    UIImage *curImage = [[self cache] objectForKey:url];
    
    if(curImage != nil) {
        handler(curImage, url);
    } else {
        loadCompleteHandler = [handler copy];
        loadUrl = [[NSString alloc] initWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if(connection) {
            receivedData = [[NSMutableData data] retain];
        }
    }
}

#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage *downloadedImage = [UIImage imageWithData:receivedData];
    
    if( [[self cache] count] >= MAX_CACHED_IMAGES )
        [[self cache] removeAllObjects];
    
    [[self cache] setValue:downloadedImage forKey:loadUrl];
    
    loadCompleteHandler(downloadedImage, loadUrl);
    [receivedData release];
    [connection release];
}

@end
