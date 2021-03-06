//
//  SKEmitterNode+DTZExtensions.h
//  SpaceRun
//
//  Created by Charles Feduke on 5/5/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKEmitterNode (DTZExtensions)

+ (SKEmitterNode *)dtz_nodeWithFile:(NSString *)filename;
- (void)dtz_dieOutInDuration:(NSTimeInterval)duration;

@end
