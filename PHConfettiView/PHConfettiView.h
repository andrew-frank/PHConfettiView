//
//  PHConfettiView.h
//  PHConfettiView
//
//  Created by Andrzej on 06/03/16.
//  Copyright © 2016 A&A.make LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PHConfettiTypeConfetti,
    PHConfettiTypeTriangle,
    PHConfettiTypeStar,
    PHConfettiTypeDiamond,
    PHConfettiTypeCustom
} PHConfettiType;

@interface PHConfettiView : UIView

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) CGFloat intensity;
@property (nonatomic, assign) CGFloat birthRate;
@property (nonatomic, assign) PHConfettiType type;
@property (nonatomic, strong) UIImage *customImage;

-(void)startConfetti;
-(void)stopConfetti;

@property (nonatomic, assign, readonly) BOOL isRaining;

@end
