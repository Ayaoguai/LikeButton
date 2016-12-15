//
//  LikeButton.m
//  点赞按钮
//
//  Created by 天利合 on 2016/12/14.
//  Copyright © 2016年 天利合. All rights reserved.
//

#import "LikeButton.h"

@interface LikeButton()
@property (nonatomic, weak) CAEmitterLayer *emitterLayer;
@end
@implementation LikeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        //默认的动画类型是图片放大
        self.animationType = ButtonAnimationTypeScale;
        [self setupEmitter];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupEmitter];
}
- (void)setupEmitter {
    // 粒子使用CAEmitterCell初始化
    CAEmitterCell *emitterCell   = [CAEmitterCell emitterCell];
    // 粒子的名字,在设置喷射个数的时候会用到
    emitterCell.name             = @"emitterCell";
    // 粒子的生命周期和生命周期范围
    emitterCell.lifetime         = 0.7;
    emitterCell.lifetimeRange    = 0.3;
    // 粒子的发射速度和速度的范围
    emitterCell.velocity         = 30.00;
    emitterCell.velocityRange    = 8.00;
    // 粒子的缩放比例和缩放比例的范围
    emitterCell.scale            = 0.1;
    emitterCell.scaleRange       = 0.02;
    
    // 粒子透明度改变范围
    emitterCell.alphaRange       = 0.10;
    // 粒子透明度在生命周期中改变的速度
    emitterCell.alphaSpeed       = -0.5;
    // 设置粒子的图片
    emitterCell.contents         = (id)[UIImage imageNamed:@"Sparkle3"].CGImage;
    
    /// 初始化粒子发射器
    CAEmitterLayer *layer        = [CAEmitterLayer layer];
    // 粒子发射器的 名称
    layer.name                   = @"emitterLayer";
    // 粒子发射器的 形状(可以想象成打仗时,你需要的使用的炮的形状)
    layer.emitterShape           = kCAEmitterLayerCircle;
    // 粒子发射器 发射的模式
    layer.emitterMode            = kCAEmitterLayerOutline;
    // 粒子发射器 中的粒子 (炮要使用的炮弹)
    layer.emitterCells           = @[emitterCell];
    // 定义粒子细胞是如何被呈现到layer中的
    layer.renderMode             = kCAEmitterLayerOldestFirst;
    // 不要修剪layer的边界
    layer.masksToBounds          = NO;
    // z 轴的相对坐标 设置为-1 可以让粒子发射器layer在self.layer下面
    layer.zPosition              = -1;
    // 添加layer
    [self.layer addSublayer:layer];
    _emitterLayer = layer;
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    //开始动画
    [self animation];
}
#pragma - mark 开始动画
- (void)animation {
    if (self.selected) {
        switch (self.animationType) {
            case ButtonAnimationTypeScale:
            {
                [self startScale];
            }
                break;
            case ButtonAnimationTypeEmitter:
            {
                [self startFire];
            }
                break;
        }
    }
}
#pragma - mark 动画放大
- (void)startScale {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5, @0.8, @1.0, @1.2, @1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [self.imageView.layer addAnimation:animation forKey:@"transform.scale"];
}
#pragma - mark 粒子发散效果
- (void)startFire {
    // 每秒喷射的80个
    [self.emitterLayer setValue:@1000 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    // 开始
    self.emitterLayer.beginTime = CACurrentMediaTime();
    // 执行停止
    [self performSelector:@selector(stopFire) withObject:nil afterDelay:0.1];
}
- (void)stopFire {
    [self.emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitterCell.birthRate"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _emitterLayer.position = self.imageView.center;
}
@end
