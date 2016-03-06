//
//  JWPageView.h
//  ScrollView Demo
//
//  Created by ljw on 16/3/3.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWPageView : UIView
/**
 *  图片名数组
 */
@property (nonatomic , copy) NSArray *imageArray;

+(instancetype)pageViews;

@end
