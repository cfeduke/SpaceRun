#import "DTZMyScene.h"

@interface DTZMyScene ()
@property (nonatomic, weak) UITouch *shipTouch;
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

- (void)update:(NSTimeInterval)currentTime
{
    if (self.shipTouch) {
        SKNode *ship = [self childNodeWithName:@"ship"];
        ship.position = [self.shipTouch locationInNode:self];
    }
}
@end