//
//  DTZMenuViewController.h
//  SpaceRun
//
//  Created by Charles Feduke on 5/7/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTZStarField.h"

@interface DTZMenuViewController : UIViewController
@property (nonatomic, strong) IBOutlet UISegmentedControl *difficultyChooser;
@property (nonatomic, strong) SKView *demoView;
@end
