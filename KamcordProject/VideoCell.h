//
//  VideoCell.h
//  KamcordProject
//
//  Created by Yonglin Wu on 10/12/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@end
