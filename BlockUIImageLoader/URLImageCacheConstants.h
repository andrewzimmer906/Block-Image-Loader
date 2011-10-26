//
//  URLImageCacheConstants.h
//  Tout
//
//  Created by Andrew Zimmer on 9/30/11.
//  Copyright (c) 2011 Toutapp. All rights reserved.
//

#ifndef Tout_URLImageCacheConstants_h
#define Tout_URLImageCacheConstants_h

typedef void(^URLImageLoadCompleteHandler)(UIImage *imageLoaded, NSString *url);
#define MAX_CACHED_IMAGES 60  //this should cover it for normal use.

#endif
