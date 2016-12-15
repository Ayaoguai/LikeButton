//
//  LikeButton.h
//  点赞按钮
//
//  Created by 天利合 on 2016/12/14.
//  Copyright © 2016年 天利合. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ButtonAnimationType){
    /**图片放大缩小-- 默认类型*/
    ButtonAnimationTypeScale,
    /**图片周围出现粒子效果*/
    ButtonAnimationTypeEmitter
};
@interface LikeButton : UIButton
/**设置动画效果*/
@property (nonatomic) ButtonAnimationType animationType;
@end
