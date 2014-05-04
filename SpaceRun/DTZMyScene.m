#import "DTZMyScene.h"

@interface DTZMyScene ()
@property (nonatomic, weak) UITouch *shipTouch;
@property (nonatomic) NSTimeInterval lastUpdateTime;
@property (nonatomic) NSTimeInterval lastShotFireTime;
@end

@implementation DTZMyScene

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        
        NSString *name = @"Spaceship.png";
        SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:name];
        ship.position = CGPointMake(size.width / 2, size.height / 2);
        ship.size = CGSizeMake(40, 40);
        ship.name = @"ship";
        [self addChild:ship];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.shipTouch = [touches anyObject];
}

- (void)moveShipTowardPoint:(CGPoint)point byTimeDelta:(NSTimeInterval)timeDelta
{
    CGFloat shipSpeed = 130;
    SKNode *ship = [self childNodeWithName:@"ship"];
    CGFloat distanceLeft = sqrt(pow(ship.position.x - point.x, 2) +
                                pow(ship.position.y - point.y, 2));
    
    if (distanceLeft > 4) {
        CGFloat distanceToTravel = timeDelta * shipSpeed;
        
        CGFloat angle = atan2(point.y - ship.position.y,
                              point.x - ship.position.x);
        CGFloat yOffset = distanceToTravel * sin(angle);
        CGFloat xOffset = distanceToTravel * cos(angle);
        
        ship.position = CGPointMake(ship.position.x + xOffset,
                                    ship.position.y + yOffset);
    }
        
}

- (void)shoot
{
    SKNode *ship = [self childNodeWithName:@"ship"];
    
    SKSpriteNode *photon = [SKSpriteNode spriteNodeWithImageNamed:@"photon"];
    photon.name = @"photon";
    photon.position = ship.position;
    [self addChild:photon];
    
    SKAction *fly = [SKAction moveByX:0
                                    y:self.size.height + photon.size.height
                             duration:0.5];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *fireAndRemove = [SKAction sequence:@[fly, remove]];
    [photon runAction:fireAndRemove];
}

- (void)dropAsteroid
{
    CGFloat sideSize = 15 + arc4random_uniform(30);
    CGFloat maxX = self.size.width;
    CGFloat quarterX = maxX / 4;
    CGFloat startX = arc4random_uniform(maxX + (quarterX * 2)) - quarterX;
    CGFloat startY = self.size.height + sideSize;
    CGFloat endX = arc4random_uniform(maxX);
    CGFloat endY = 0 - sideSize;
    
    SKSpriteNode *asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid"];
    asteroid.size = CGSizeMake(sideSize, sideSize);
    asteroid.position = CGPointMake(startX, startY);
    asteroid.name = @"obstacle";
    [self addChild:asteroid];
    
    SKAction *move = [SKAction moveTo:CGPointMake(endX, endY)
                             duration:3 + arc4random_uniform(4)];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *travelAndRemove = [SKAction sequence:@[move, remove]];
    
    SKAction *spin = [SKAction rotateByAngle:3 duration:arc4random_uniform(2) + 1];
    SKAction *spinForever = [SKAction repeatActionForever:spin];
    
    SKAction *all = [SKAction group:@[spinForever, travelAndRemove]];
    [asteroid runAction:all];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTime == 0) {
        self.lastUpdateTime = currentTime;
    }
    NSTimeInterval timeDelta = currentTime - self.lastUpdateTime;
    
    if (self.shipTouch) {
        [self moveShipTowardPoint:[self.shipTouch locationInNode:self]
                      byTimeDelta:timeDelta];
        
        if (currentTime - self.lastShotFireTime > 0.5) {
            [self shoot];
            self.lastShotFireTime = currentTime;
        }
    }
    
    if (arc4random_uniform(1000) <= 15) {
        [self dropAsteroid];
    }
    

    
    self.lastUpdateTime = currentTime;
}
@end