//
//  Video.h
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^VideoDownloadingCompletionBlock)();

@interface Video : NSObject

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *videoUrlString;

- (instancetype)initWithURL:(NSURL *)url andCompletionBlock:(VideoDownloadingCompletionBlock)completionBlock;

@end
