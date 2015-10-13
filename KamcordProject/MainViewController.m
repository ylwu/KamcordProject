//
//  MainViewController.m
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import "MainViewController.h"
#import "VideoCell.h"
#import "VideoManager.h"
#import "Video.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"

@interface MainViewController ()

@property NSArray *videos;

@end

@implementation MainViewController

static NSString* cellIdentifier = @"VideoCell";
static float kCellHeight = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFetched) name:kDataFetchedNotification object:nil];
    //preseting a view showing "videos loading" while waiting for video metadata to be downloaded
    [self performSegueWithIdentifier:@"ShowVideosLoading" sender:self];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:cellIdentifier];
    }
    
    Video *video = (Video*) self.videos[indexPath.row];
    cell.titleLabel.text = video.title;
    cell.usernameLabel.text = video.userName;
    cell.thumbnailView.image = video.thumbnail;
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //present AVPlayerViewController as a movie player for the video.
    AVPlayerViewController *presentingVC = [[AVPlayerViewController alloc] init];
    Video *video = (Video*) self.videos[indexPath.row];
    NSURL *videoURL = [[NSURL alloc] initWithString:video.videoUrlString];
    presentingVC.player = [[AVPlayer alloc] initWithURL:videoURL];
    [self presentViewController:presentingVC animated:YES completion:nil];
    [presentingVC.player play];
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return kCellHeight;
}

#pragma mark - Helper methods
- (void) dataFetched {
    //when receiving notification that all video thumbnails have been downloaded, dismiss "Video loading" view.
    _videos = [VideoManager sharedInstance].videos;
    [self.navigationController popViewControllerAnimated:NO];
    [self.tableView reloadData];
}

@end
