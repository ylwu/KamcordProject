//
//  PushNoAnimationSegue.m
//  KamcordProject
//
//  Created by Yonglin Wu on 10/13/15.
//  Copyright © 2015 JasonWu. All rights reserved.
//

#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue

-(void) perform{
    [[[self sourceViewController] navigationController] pushViewController:[self   destinationViewController] animated:NO];
}

@end
