//
//  CircleLayer.m
//  AnimationedCycleDemo
//
//  Created by zhangdongpo on 16/8/8.
//  Copyright © 2016年 zhangdongpo. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MovePoint){
    POINT_D,
    POINT_B
};
#define outsideRectSize 90

@interface CircleLayer ()
/**
 *  外接矩形
 */
@property (nonatomic, assign) CGRect outsideRect;
/**
 *  记录上次的progress，方便做差获得滑动方向
 */
@property (nonatomic, assign) CGFloat lastProgress;
/**
 *  实时记录滑动方向
 */
@property (nonatomic, assign) MovePoint movePoint;
@end
@implementation CircleLayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lastProgress = 0.5;
    }
    return self;
}
-(instancetype)initWithLayer:(CircleLayer *)layer
{
    self = [super initWithLayer:layer];
    if (self) {
        self.progress = layer.progress;
        self.lastProgress = layer.lastProgress;
        self.outsideRect = layer.outsideRect;
    }
    return self;
}
-(void)drawInContext:(CGContextRef)ctx
{
    //A-C1,B-C2的距离，当设置为正方形边长的1/3.6时，画出来的圆弧完美贴合圆形
    CGFloat offset = self.outsideRect.size.width * 1 / 3.6;
    
    //A.B.C.D实际需要移动的距离.系数为滑块偏离中点0.5的绝对值再乘以2.当滑到两端的时候，movedDistance为最大值：「外接矩形宽度的1/5」.
    CGFloat moveDistance = (self.outsideRect.size.width * 1 / 6) * fabs(self.progress - 0.5) * 2;
    
    //方便下面计算个点坐标，先算出外接矩形中心点坐标
    CGPoint rectCenter = CGPointMake(self.outsideRect.size.width * 0.5 + self.outsideRect.origin.x, self.outsideRect.origin.y + self.outsideRect.size.height * 0.5);
    
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + moveDistance);
    
    CGPoint pointB = CGPointMake(self.movePoint == POINT_D ? rectCenter.x + self.outsideRect.size.width * 0.5 : rectCenter.x + self.outsideRect.size.width * 0.5 + moveDistance * 2, rectCenter.y);
    
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height/2 - moveDistance);
    
    CGPoint pointD = CGPointMake(self.movePoint == POINT_D ? self.outsideRect.origin.x - moveDistance * 2 : rectCenter.x - self.outsideRect.size.width * 0.5, rectCenter.y);
    
    CGPoint pointC1 = CGPointMake(pointA.x + offset, pointA.y);
    
    CGPoint pointC2 = CGPointMake(pointB.x ,self.movePoint == POINT_D ? pointB.y - offset : pointB.y - offset + moveDistance);
    
    CGPoint pointC3 = CGPointMake(pointB.x , self.movePoint == POINT_D ? pointB.y + offset : pointB.y + offset - moveDistance);
    
    CGPoint pointC4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint pointC5 = CGPointMake(pointC.x - offset, pointC.y);
    
    CGPoint pointC6 = CGPointMake(pointD.x , self.movePoint == POINT_D ? pointD.y + offset - moveDistance : pointD.y + offset );
    
    CGPoint pointC7 = CGPointMake(pointD.x , self.movePoint == POINT_D ? pointD.y - offset + moveDistance : pointD.y - offset );
    
    CGPoint pointC8 = CGPointMake(pointA.x - offset, pointA.y);
    
    
}
@end
