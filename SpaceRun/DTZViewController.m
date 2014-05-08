//
//  DTZViewController.m
//  SpaceRun
//
//  Created by Charles Feduke on 5/3/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import "DTZViewController.h"
#import "DTZMyScene.h"
#import "DTZOpeningScreen.h"

@implementation DTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene *blackScene = [[SKScene alloc] initWithSize:skView.bounds.size];
    blackScene.backgroundColor = [SKColor blackColor];
    [skView presentScene:blackScene];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SKView *skView = (SKView *)self.view;
    
    DTZOpeningScreen *scene = [DTZOpeningScreen sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition *transition = [SKTransition fadeWithDuration:1];
    [skView presentScene:scene transition:transition];
    
    __weak DTZViewController *weakSelf = self;
    scene.sceneEndCallback = ^{
        // Create and configure the scene.
        DTZMyScene *scene = [DTZMyScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        scene.easyMode = weakSelf.easyMode;
        
        scene.endGameCallback = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        SKTransition *transition = [SKTransition fadeWithColor:[SKColor blackColor] duration:1];
        [skView presentScene:scene transition:transition];

    };
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
