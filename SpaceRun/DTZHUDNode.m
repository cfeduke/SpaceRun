//
//  DTZHUDNode.m
//  SpaceRun
//
//  Created by Charles Feduke on 5/8/14.
//  Copyright (c) 2014 Deployment Zone. All rights reserved.
//

#import "DTZHUDNode.h"

@interface DTZHUDNode ()
@property (nonatomic, strong) NSNumberFormatter *scoreFormatter;
@property (nonatomic, strong) NSNumberFormatter *timeFormatter;
@property (nonatomic, strong) SKLabelNode *scoreValue;
@property (nonatomic, strong) SKLabelNode *elapsedValue;
@end

@implementation DTZHUDNode

- (instancetype)init {
    if (self = [super init]) {
        SKNode *scoreGroup = [SKNode node];
        scoreGroup.name = @"scoreGroup";
        
        SKLabelNode *scoreTitle = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        scoreTitle.fontSize = 12;
        scoreTitle.fontColor = [SKColor whiteColor];
        scoreTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        scoreTitle.text = @"SCORE";
        scoreTitle.position = CGPointMake(0, 4);
        [scoreGroup addChild:scoreTitle];
        
        self.scoreValue = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
        self.scoreValue.fontSize = 20;
        self.scoreValue.fontColor = [SKColor whiteColor];
        self.scoreValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.scoreValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.scoreValue.name = @"scoreValue";
        self.scoreValue.text = @"0";
        self.scoreValue.position = CGPointMake(0, -4);
        [scoreGroup addChild:self.scoreValue];
        
        [self addChild:scoreGroup];
        
        SKNode *elapsedGroup = [SKNode node];
        elapsedGroup.name = @"elapsedGroup";
        
        SKLabelNode *elapsedTitle = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Medium"];
        elapsedTitle.fontSize = 12;
        elapsedTitle.fontColor = [SKColor whiteColor];
        elapsedTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        elapsedTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        elapsedTitle.text = @"TIME";
        elapsedTitle.position = CGPointMake(0, 4);
        [elapsedGroup addChild:elapsedTitle];
        
        self.elapsedValue = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
        self.elapsedValue.fontSize = 20;
        self.elapsedValue.fontColor = [SKColor whiteColor];
        self.elapsedValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        self.elapsedValue.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        self.elapsedValue.name = @"elapsedValue";
        self.elapsedValue.text = @"0.0s";
        self.elapsedValue.position = CGPointMake(0, -4);
        [elapsedGroup addChild:self.elapsedValue];
        
        [self addChild:elapsedGroup];
        
        self.scoreFormatter = [[NSNumberFormatter alloc] init];
        self.scoreFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        self.timeFormatter = [[NSNumberFormatter alloc] init];
        self.timeFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        self.timeFormatter.minimumFractionDigits = 1;
        self.timeFormatter.maximumFractionDigits = 1;
    }
    return self;
}

- (void)layoutForScene {
    NSAssert(self.scene, @"Cannot be called unless added to a scene");
    
    CGSize sceneSize = self.scene.size;
    
    CGSize groupSize = CGSizeZero;
    
    SKNode *scoreGroup = [self childNodeWithName:@"scoreGroup"];
    groupSize = [scoreGroup calculateAccumulatedFrame].size;
    scoreGroup.position = CGPointMake(0 - sceneSize.width / 2 + 20, sceneSize.height / 2 - groupSize.height);
    
    SKNode *elapsedGroup = [self childNodeWithName:@"elapsedGroup"];
    groupSize = [elapsedGroup calculateAccumulatedFrame].size;
    elapsedGroup.position = CGPointMake(sceneSize.width / 2 - 20, sceneSize.height / 2 - groupSize.height);
    
}

-(void)addPoints:(NSInteger)points {
    self.score += points;
    
    self.scoreValue.text = [NSString stringWithFormat:@"%@", [self.scoreFormatter stringFromNumber:@(self.score)]];
    
    SKAction *scale = [SKAction scaleTo:1.1 duration:0.02];
    SKAction *shrink = [SKAction scaleTo:1 duration:0.07];
    SKAction *all = [SKAction sequence:@[scale, shrink]];
    [self.scoreValue runAction:all];
}

-(void)startGame {
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    
    __weak DTZHUDNode *weakSelf = self;
    SKAction *update = [SKAction runBlock:^{
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval elapsed = now - startTime;
        weakSelf.elapsedTime = elapsed;
        self.elapsedValue.text = [NSString stringWithFormat:@"%@s", [weakSelf.timeFormatter stringFromNumber:@(elapsed)]];
    }];
    
    SKAction *delay = [SKAction waitForDuration:0.05];
    SKAction *updateAndDelay = [SKAction sequence:@[update, delay]];
    SKAction *timer = [SKAction repeatActionForever:updateAndDelay];
    
    [self runAction:timer withKey:@"elapsedGameTimer"];
}

-(void)endGame {
    [self removeActionForKey:@"elapsedGameTimer"];
}
@end
