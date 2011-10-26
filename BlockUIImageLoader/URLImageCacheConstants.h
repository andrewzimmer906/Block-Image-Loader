//
//  URLImageCacheConstants.h
//  Andrew Zimmer
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
//  Constants for the URLImageCached Loader.
//

#ifndef URLImageCacheConstants_h
#define URLImageCacheConstants_h

typedef void(^URLImageLoadCompleteHandler)(UIImage *imageLoaded, NSString *url);
typedef void(^URLImageLoadProgressHandler)(float progress, NSString *url);

#define MAX_CACHED_IMAGES 60  //this should cover it for normal use.

#endif
