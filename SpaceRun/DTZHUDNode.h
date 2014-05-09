//
//  DTZHUDNode.h
//  SpaceRun
//
//  Created by Charles Feduke on 5/8/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DTZHUDNode : SKNode
- (void)layoutForScene;

- (void)addPoints:(NSInteger)points;
- (void)startGame;
- (void)endGame;

@property (nonatomic) NSTimeInterval elapsedTime;
@property (nonatomic) NSInteger score;
@end
