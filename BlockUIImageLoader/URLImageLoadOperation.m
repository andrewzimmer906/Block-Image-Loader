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

#pragma mark - Public Methods
-(void)loadImageWithURL:(NSString*)url withLoadProgressHandler:(URLImageLoadProgressHandler)progressHandler withLoadCompleteHandler:(URLImageLoadCompleteHandler)completeHandler {
    UIImage *curImage = [[self cache] objectForKey:url];
    
    if(curImage != nil) {
        if(progressHandler != nil) {
            progressHandler(1, url);
        }
        completeHandler(curImage, url);
    } else {
        loadCompleteHandler = [completeHandler copy];
        loadProgressHandler = [progressHandler copy];
        if(loadProgressHandler)  {
            loadProgressHandler(0.0f, url);
        }
        
        loadUrl = [[NSString alloc] initWithString:url];
        expectedContentLength = NSURLResponseUnknownLength;
        
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
    expectedContentLength = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    if(expectedContentLength != NSURLResponseUnknownLength && loadProgressHandler != nil) {
        loadProgressHandler((float)[receivedData length] / (float)expectedContentLength, loadUrl);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage *downloadedImage = [UIImage imageWithData:receivedData];
    
    if( [[self cache] count] >= MAX_CACHED_IMAGES )
        [[self cache] removeAllObjects];
    
    [[self cache] setValue:downloadedImage forKey:loadUrl];
    
    if(loadProgressHandler != nil) {
        loadProgressHandler(1, loadUrl);
    }
    
    loadCompleteHandler(downloadedImage, loadUrl);
    [receivedData release];
    [connection release];
    [loadUrl release];
}

@end
