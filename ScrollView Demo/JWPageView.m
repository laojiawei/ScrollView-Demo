//
//  JWPageView.m
//  ScrollView Demo
//
//  Created by ljw on 16/3/3.
//  Copyright © 2016年 ljw. All rights reserved.
//

#import "JWPageView.h"

@interface JWPageView()<UIScrollViewDelegate>
/**
 *  scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  页码控制器
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageControler;
/**
 *  定时器
 */
@property (nonatomic , weak) NSTimer *timer;

@end

@implementation JWPageView


- (void)awakeFromNib
{
    // 1.单页的时候是否需要隐藏pageControl
    self.pageControler.hidesForSinglePage = YES;
    //自定义pageControler图片
    /*
    // 2.设置pageControl显示的图片(利用KVC赋值)
    [self.pageControler setValue:[UIImage imageNamed:@"current"] forKeyPath:@"_currentPageImage"];
    
    [self.pageControler setValue:[UIImage imageNamed:@"other"] forKeyPath:@"_pageImage"];
     */

    [self startTimer];
}

+(instancetype)pageViews
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.scrollView addSubview:imageView];
    }
    //总页数
    self.pageControler.numberOfPages = imageArray.count;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    
    for (int i = 0; i < self.imageArray.count; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
       
        imageView.image = [UIImage imageNamed:self.imageArray[i]];
        
        imageView.frame = CGRectMake(i * w, 0, w, h);
        
    }
    //滚动内容范围
    self.scrollView.contentSize = CGSizeMake(self.scrollView.subviews.count * w, 0);

}
#pragma mark - 定时器相关的代码
- (void)nexPage:(NSTimer *)timer
{
    //    NSLog(@"nexPage--%@",timer.userInfo);
    
    // 计算下一页页码
    NSInteger page = self.pageControler.currentPage + 1;
    
    // 超过最后一页
    if (page == self.imageArray.count) {
        page = 0;
    }
    // 滚动到下一页
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
    
}
/**
 *  开启定时器
 */
- (void)startTimer
{
    // 返回一个自动执行任务的定时器对象
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nexPage:) userInfo:@"time" repeats:YES];
    
    //线程相关
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
}


#pragma make - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 计算页码
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 设置页码
    self.pageControler.currentPage = page;
    
}

/**
 *  用户即将拖拽scrollView时,停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  用户停止拖拽scrollView时,开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}







@end
