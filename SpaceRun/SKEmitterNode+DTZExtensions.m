//
//  SKEmitterNode+DTZExtensions.m
//  SpaceRun
//
//  Created by Charles Feduke on 5/5/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import "SKEmitterNode+DTZExtensions.h"

@implementation SKEmitterNode (DTZExtensions)

+ (SKEmitterNode *)dtz_nodeWithFile:(NSString *)filename
{
    NSString *basename = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    if ([extension length] == 0) {
        extension = @"sks";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:basename ofType:@"sks"];
    SKEmitterNode *node = (id)[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return node;
}

@end
