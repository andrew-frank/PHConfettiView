//
//  ViewController.m
//  PHConfettiView
//
//  Created by Andrzej on 06/03/16.
//  Copyright © 2016 A&A.make LTD. All rights reserved.
//

#import "ViewController.h"
#import "PHConfettiView.h"

@interface ViewController ()

@property (nonatomic, strong) PHConfettiView *confettiView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.confettiView = [[PHConfettiView alloc] initWithFrame:self.view.bounds];
    self.confettiView.colors = @[[UIColor colorWithRed:0.95 green:0.40 blue:0.27 alpha:1.0],
                                 [UIColor colorWithRed:1.00 green:0.78 blue:0.36 alpha:1.0],
                                 [UIColor colorWithRed:0.48 green:0.78 blue:0.64 alpha:1.0],
                                 [UIColor colorWithRed:0.30 green:0.76 blue:0.85 alpha:1.0],
                                 [UIColor colorWithRed:0.58 green:0.39 blue:0.55 alpha:1.0]];
    
//    self.confettiView.intensity = 0.6;
//    self.confettiView.birthRate = 10;
    self.confettiView.type = PHConfettiTypeConfetti;
    
    [self.view addSubview:self.confettiView];
    
    //
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*self.view.bounds.size.width/3, 300)];
    [self.label setText:@"tap to start 🙈"];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightLight];
    self.label.numberOfLines = 2;
    self.label.center = self.view.center;
    
    [self.view addSubview:self.label];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.confettiView.frame = self.view.bounds;
    self.label.center = self.view.center;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.confettiView.isRaining) {
        [self.confettiView stopConfetti];
        [self.label setText:@"tap to start 🙈"];
        
    } else {
        [self.confettiView startConfetti];
        self.label.text = @"it's a raining confetti!  🙉";
    }
}

@end
