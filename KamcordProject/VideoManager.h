//
//  DataStore.h
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoManager : NSObject

extern NSString* const kDataFetchedNotification;

@property (retain, atomic) NSMutableArray *videos;

+ (VideoManager *) sharedInstance;
- (void) fetchAllVideos;

@end
