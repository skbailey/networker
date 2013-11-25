//
//  SKBViewController.h
//  Networker
//
//  Created by shbailey63 on 11/18/13.
//  Copyright (c) 2013 shbailey63. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKBViewController : UIViewController <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSMutableData *response;
@property (nonatomic, weak) IBOutlet UITextField *artist;
@property (nonatomic, strong) NSDictionary *spotifyData;
@property (nonatomic, strong) NSString *searchText;

@end
