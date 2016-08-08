//
//  ViewController.m
//  AnimationedCycleDemo
//
//  Created by zhangdongpo on 16/8/8.
//  Copyright © 2016年 zhangdongpo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.mySlider addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)valuechanged:(UISlider *)sender
{
    self.currentValueLabel.text = [NSString stringWithFormat:@"currentValue:%f",sender.value];
}

@end
