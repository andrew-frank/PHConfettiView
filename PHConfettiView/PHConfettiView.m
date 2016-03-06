//
//  PHConfettiView.m
//  PHConfettiView
//
//  Created by Andrzej on 06/03/16.
//  Copyright © 2016 A&A.make LTD. All rights reserved.
//

#import "PHConfettiView.h"



@interface PHConfettiView ()

@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, assign) BOOL isRaining;

@end

@implementation PHConfettiView

#pragma mark - Properties

-(void)setBirthRate:(CGFloat)birthRate
{
    if(birthRate == _birthRate)
        return;
    
    _birthRate = birthRate;
    self.emitter.birthRate = _birthRate;
}

#pragma mark - Lifecycle

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self)
        return nil;
    
    [self setupConfetti];

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
        return nil;
    
    [self setupConfetti];
    
    return self;
}

-(void)setupConfetti
{
    self.colors = @[[UIColor colorWithRed:0.95 green:0.40 blue:0.27 alpha:1.0],
                    [UIColor colorWithRed:1.00 green:0.78 blue:0.36 alpha:1.0],
                    [UIColor colorWithRed:0.48 green:0.78 blue:0.64 alpha:1.0],
                    [UIColor colorWithRed:0.30 green:0.76 blue:0.85 alpha:1.0],
                    [UIColor colorWithRed:0.58 green:0.39 blue:0.55 alpha:1.0]];
    
    self.intensity = 0.5;
    self.birthRate = 1;
    self.type = PHConfettiTypeConfetti;
}


#pragma mark - Public

-(void)startConfetti
{
    //*
    if(self.emitter == nil) {
        self.emitter = CAEmitterLayer.new;
        self.emitter.emitterPosition = CGPointMake(self.center.x, 0);
        self.emitter.emitterShape = kCAEmitterLayerLine;
        self.emitter.emitterSize = CGSizeMake(self.bounds.size.width, 1);

        
        NSMutableArray *cells = NSMutableArray.new;
        for (UIColor *color in self.colors) {
            [cells addObject:[self cellWithColor:color]];
        }
        
        self.emitter.emitterCells = cells;
        [self.layer addSublayer:self.emitter];
    }
    //*/
    
    /*
    if(self.emitter)
        [self.emitter removeFromSuperlayer];
    self.emitter = CAEmitterLayer.new;
    self.emitter.emitterPosition = CGPointMake(self.center.x, 0);
    self.emitter.emitterShape = kCAEmitterLayerLine;
    self.emitter.emitterSize = CGSizeMake(self.bounds.size.width, 1);
    
    NSMutableArray *cells = NSMutableArray.new;
    for (UIColor *color in self.colors) {
        [cells addObject:[self cellWithColor:color]];
    }
    
    self.emitter.emitterCells = cells;
    [self.layer addSublayer:self.emitter];
    */
    
    self.emitter.birthRate = self.birthRate;
    self.isRaining = YES;
}

-(void)stopConfetti
{
    if(self.emitter)
        self.emitter.birthRate = 0;
    
    self.isRaining = NO;
}

#pragma mark - Private

-(CAEmitterCell *)cellWithColor:(UIColor *)color
{
    CAEmitterCell *confetti = [CAEmitterCell new];
    
    confetti.birthRate = 6.0 * self.intensity / 2;
    confetti.lifetime = 14.0 * self.intensity * 2.2;
    confetti.lifetimeRange = 0;
    confetti.color = color.CGColor;
    confetti.velocity = (CGFloat)350.0 * self.intensity / 2.3;
    confetti.velocityRange = (CGFloat)80.0 * self.intensity;
    confetti.emissionLongitude = (CGFloat)M_PI;
    confetti.emissionRange = (CGFloat)M_PI_4;
    confetti.spin = (CGFloat)3.5 * self.intensity;
    confetti.spinRange = (CGFloat)4.0 * self.intensity;
    confetti.scaleRange = (CGFloat)self.intensity;
    confetti.scaleSpeed = (CGFloat)(-0.1 * self.intensity);
    
    //__bridge:
    //https://developer.apple.com/library/ios/documentation/CoreFoundation/Conceptual/CFDesignConcepts/Articles/tollFreeBridgedTypes.html
    //http://stackoverflow.com/questions/18067108/when-should-you-use-bridge-vs-cfbridgingrelease-cfbridgingretain
    confetti.contents = (__bridge id _Nullable)([self imageForType:self.type].CGImage);
    
    return confetti;
}

-(UIImage *)imageForType:(PHConfettiType)type
{
    NSString *filename;
    switch (type) {
        case PHConfettiTypeConfetti:
            filename = @"confetti";
            break;
        case PHConfettiTypeTriangle:
            filename = @"triangle";
            break;
        case PHConfettiTypeStar:
            filename = @"star";
            break;
        case PHConfettiTypeDiamond:
            filename = @"diamond";
            break;
        case PHConfettiTypeCustom:
            return self.customImage;
            break;
        default:
            return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ConfettiImages" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
#if DEBUG
    NSAssert(bundle, @"No bundle");
#endif
    
    NSString *imagePath = [bundle pathForResource:filename ofType:@"png"];
    NSURL *url = [NSURL fileURLWithPath:imagePath];
    NSData * data = [NSData dataWithContentsOfURL:url];
    if(data)
        return [UIImage imageWithData:data];
    return nil;
    
//    NSString *imgName = [NSString stringWithFormat:@"ConfettiImages.bundle/%@.png", filename];
//    return [UIImage imageNamed:imgName];
}

@end
