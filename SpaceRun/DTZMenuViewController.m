//
//  DTZMenuViewController.m
//  SpaceRun
//
//  Created by Charles Feduke on 5/7/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import "DTZMenuViewController.h"
#import "DTZViewController.h"

@interface DTZMenuViewController ()

@end

@implementation DTZMenuViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"play-game"]) {
        DTZViewController *viewController = segue.destinationViewController;
        viewController.easyMode = self.difficultyChooser.selectedSegmentIndex == 0;
    } else {
        NSAssert(false, @"Unknown segue identifier %@", segue.identifier);
    }
}
@end
