Block Image Loader
=====

Load a UIImage from a remote URL location in just a few lines of code.
EXTRA BONUS: We are using blocks for our handlers!

I created these two classes recently to enable myself to easily and efficiently load UIImage's from a remote URL asynchronously.
	I set up blocks to manage the handlers, oh yeah! 

* Asynchronously load UIImage's with just a few lines of code.
* This is NOT a category on the UIImageView, so its much more flexible.
* You get to do things in blocks! No more delegates!
* Built in progress handler.
* Built in reachability testing.

**How to use**  
First, download the code, and include it in your source.

Import the class:
     #import "URLImageCached.h"
     
Now, start loading images
    -(void)loadImage {
	    BOOL loading = [URLImageCached loadImageWithURL:@"http://imageurl.png" 
	    					   withLoadCompleteHandler:^void(UIImage *loadedImage, NSString *url) {
	    					       //Handle loaded image here. Set it to a UIImageView. Whatever..
	    					   }];
	    if(!loading) { NSLog(@"You'll need internet for this."); }
    }
    
It's just as easy to include a progress indicator:
    -(void)loadImageWithProgress {
		BOOL loading = [URLImageCached loadImageWithURL:@"http://imageurl.png" 
		                       withLoadProgressHandler:^void(float progress, NSString *url) {
		                           //Handle the progress here. It'll go from 0.0 to 1.0.		    
		                       }
							   withLoadCompleteHandler:^void(UIImage *loadedImage, NSString *url) {
							       //Handle loaded image here. Set it to a UIImageView. Whatever..
							   }];
		if(!loading) { NSLog(@"You'll need internet for this."); }
    }
    

**Questions or Comments:**   
Email: andrewzimmer906@gmail.com  
Twitter: @andrewzimmer906  
