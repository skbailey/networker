//
//  SKBViewController.m
//  Networker
//
//  Created by shbailey63 on 11/18/13.
//  Copyright (c) 2013 shbailey63. All rights reserved.
//

#import "SKBViewController.h"
#import "SKBTableViewController.h"

@interface SKBViewController ()

@end

@implementation SKBViewController

@synthesize urlSession;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  // Create the URL Session & Configuration
  NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  self.urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeRequest:(id)sender {
  NSLog(@"Make a Spotify request");
  
  CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                      (__bridge CFStringRef)(self.artist.text), NULL, CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
  NSString *url = [NSString stringWithFormat:@"https://mager-spotify-web.p.mashape.com/search/1/album.json?q=%@", encodedString];
  NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  [urlRequest setValue:@"Fdjwqv9HGgTSPv0vG3wRv0uAVj5YiAP2" forHTTPHeaderField:@"X-Mashape-Authorization"];
  
  NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:urlRequest];
  [dataTask resume];
}

#pragma mark -
#pragma mark URLSession Delegate Methods

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
  NSLog(@"Received a response!");
  self.response = [NSMutableData dataWithCapacity: 0];
  [self.response setLength:0];
  completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
  [self.response appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
  NSLog(@"URL Request Completed");
  if (error) {
    NSLog(@"Task Completed with error: %@", [error description]);
    self.response = nil;
  } else {
    NSDictionary *spotifyData = [NSJSONSerialization JSONObjectWithData:self.response options:NSJSONReadingMutableContainers error:nil];
    [spotifyData enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop){
      //NSLog(@"Key: %@, Value: %@", (NSString *)key, (NSString *)value);
    }];
    
    SKBTableViewController *myTableViewController = (SKBTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MyTableViewer"];
    myTableViewController.tableData = [spotifyData valueForKey:@"albums"];
    [self presentViewController:myTableViewController animated:YES completion:nil];
  }
}

@end
