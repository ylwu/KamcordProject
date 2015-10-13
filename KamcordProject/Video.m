//
//  Video.m
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import "Video.h"

@implementation Video

- (instancetype)initWithURL:(NSURL *)url andCompletionBlock:(VideoDownloadingCompletionBlock)completionBlock{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"Thumbnail image dataload error for url %@ with description %@", url,error);
        } else {
            //NSLog(@"thumbnail download finished");
            self.thumbnail = [UIImage imageWithData:data];
        }
        if (completionBlock){
            completionBlock();
        }
    }];
    [task resume];
    return self;
}

@end
