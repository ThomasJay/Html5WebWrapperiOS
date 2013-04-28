//
//  ViewController.m
//  HTML5 Web
//
//  Created by Tom Jay on 4/27/13.
//  Copyright (c) 2013 Tom Jay. All rights reserved.
//

#import "WebViewController.h"
#import "ZipArchive.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize webView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *resourcesFolder = [documentsDirectory stringByAppendingPathComponent: @"Resources"];
    
    // Get the url from the values dictionary
    NSString *htmlFileToLoad = [NSString stringWithFormat:@"%@/www/index.html", resourcesFolder];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlFileToLoad]];
    
    [self installHTMLComponents];
    
    [[self.webView scrollView] setBounces: NO];
    
//    [[self.webView.subviews objectAtIndex:0] setScrollEnabled:NO];
    
    [self.webView loadRequest:request];


}


// Load bundle file www.zip into the Downloads folder and unzip to Resources folder
-(void) installHTMLComponents {
    
    NSString *zipFileName = @"www.zip";
    
    NSData *rawData = nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"www" ofType:@"zip"];
    
    rawData = [NSData dataWithContentsOfFile:filePath];
    
    
    if (rawData == nil)
        return;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = YES;
    
    // Create iOS path for DownLoads directory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *resourcesFolderPath = [documentsDirectory stringByAppendingPathComponent: @"Downloads"];
    
    NSString *extractPath = [documentsDirectory stringByAppendingPathComponent: @"Resources"];
    
    if (![fm fileExistsAtPath:resourcesFolderPath isDirectory:&isDirectory]) {
        NSError *error = nil;
        
        // Create if it does not exist
        [fm createDirectoryAtPath:resourcesFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
        
		if(error) {
            NSLog(@"installHTMLComponents %@ folder could not be created error=%@", @"Downloads", [error localizedDescription]);
            
            return;
        }
    }
    
    
    NSString *zipFilePath = [resourcesFolderPath stringByAppendingPathComponent: zipFileName];
    
    
    // Do the actual write, we can be sure that any folder is already created for our base file
    [fm createFileAtPath:zipFilePath contents:rawData attributes:nil];
    
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    
    if ([zipArchive UnzipOpenFile:zipFilePath]) {
        
        BOOL ret = [zipArchive UnzipFileTo:extractPath overWrite: YES];
        
        if (NO == ret){
        }
        
        [zipArchive UnzipCloseFile];
    }
    [zipArchive release];
    
    
    
}


#pragma mark WebView Delegates


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
    return YES;
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

- (void)dealloc {
    self.webView = nil;
    [super dealloc];
}
@end
