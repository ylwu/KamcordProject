//
//  DataStore.m
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import "VideoManager.h"
#import "Video.h"

@implementation VideoManager

static NSString* baseURLString = @"https://app.kamcord.com/app/v3/feeds/featured_feed";
NSString* const kDataFetchedNotification = @"DATA_FETCHED";

// Using a singleton of VideoManager to store data.
+ (VideoManager *)sharedInstance {
    static VideoManager *dfself = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if (!dfself) {
            dfself = [[VideoManager alloc] init];
            dfself.videos = [[NSMutableArray array] mutableCopy];
        }
    });
    return dfself;
}

- (void) fetchAllVideos {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:baseURL];
    [request setValue:@"abc123" forHTTPHeaderField:@"device-token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"NSURLSession Error: %@",error.description);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError != nil){
                NSLog(@"Parsing Json Error: %@", jsonError.description);
            }
            
            NSArray *videoDataArray = responseDict[@"response"][@"video_list"][@"video_list"];
            dispatch_group_t downloadGroup = dispatch_group_create();
            
            //after fetching metadata of the vidoes, asynchronously load thumbnails of all videos
            for (int i = 0; i < [videoDataArray count]; i++){
                dispatch_group_enter(downloadGroup);
                NSURL *url = [[NSURL alloc] initWithString:(NSString *)(videoDataArray[i][@"thumbnails"][@"regular"])];
                Video *video = [[Video alloc] initWithURL:url andCompletionBlock:^{dispatch_group_leave(downloadGroup);}];
                video.title = videoDataArray[i][@"title"];
                video.userName = videoDataArray[i][@"user"][@"username"];
                video.videoUrlString = videoDataArray[i][@"video_url"];
                [self.videos addObject:video];
            }
            
            // wait until all thumbnail downloads are finished to notify MainViewController.
            dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kDataFetchedNotification object:self];
            });
        }
    }];
        
    [task resume];
}

@end
