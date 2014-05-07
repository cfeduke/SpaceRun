//
//  DTZMyScene.h
//  SpaceRun
//

//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DTZMyScene : SKScene
@property (nonatomic, copy) dispatch_block_t endGameCallback;
@property (nonatomic) BOOL easyMode;
@end
