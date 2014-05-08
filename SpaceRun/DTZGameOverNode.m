//
//  DTZGameOverNode.m
//  SpaceRun
//
//  Created by Charles Feduke on 5/8/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import "DTZGameOverNode.h"

@implementation DTZGameOverNode

- (instancetype)init {
    if (self = [super init]) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Heavy"];
        label.fontSize = 32;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Game Over";
        [self addChild:label];
        
        label.alpha = 0;
        label.xScale = 0.2;
        label.yScale = 0.2;
        
        SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:2];
        SKAction *scaleTo = [SKAction scaleTo:1 duration:2];
        SKAction *fadeAndScale = [SKAction group:@[fadeIn, scaleTo]];
        [label runAction:fadeAndScale];
        
        SKLabelNode *instructions = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        instructions.fontSize = 14;
        instructions.fontColor = [SKColor whiteColor];
        instructions.text = @"tap to play again";
        instructions.position = CGPointMake(0, -45);
        [self addChild:instructions];
        
        instructions.alpha = 0;
        SKAction *wait = [SKAction waitForDuration:4];
        SKAction *appear = [SKAction fadeAlphaTo:1 duration:2];
        SKAction *popup = [SKAction scaleTo:1.1 duration:0.1];
        SKAction *dropdown = [SKAction scaleTo:1.0 duration:0.1];
        SKAction *pauseAndAppear = [SKAction group:@[wait, appear, popup, dropdown]];
        [instructions runAction:pauseAndAppear];
    }
    return self;
}
@end
