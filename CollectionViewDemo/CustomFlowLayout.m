//
//  CustomFlowLayout.m
//  CollectionViewDemo
//
//  Created by S on 2018/2/24.
//  Copyright © 2018年 S. All rights reserved.
//


/*
 1 、Cell的放大缩小
 2 、停止滚动时候，cell剧中
 */
#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

-(instancetype)init{
    if ( self  = [super init] ) {
        
        /*
         UICollectionViewLayoutAttributes
         
         1 、 一个cell 对应一个UICollectionViewLayoutAttributes
         2 、 UICollectionViewLayoutAttributes对象决定了cell的frame
         
         */
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
        
    }
    return self;
}
/*
 返回值是一个数组，数组里面存放着rect范围内所有元素的布局属性，返回值决定了rect范围内所有元素的排布 frame
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    //越往中间越大，越往两边越小，通过cell的中心点和collectionview的中心点比较
    //计算collectionview最中心点的x值
    CGFloat centenrx = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    
    //在原有布局的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        NSLog(@"%f----%f---%f---%f",attrs.center.x,centenrx,ABS(attrs.center.x - centenrx),self.collectionView.frame.size.width);
        
        CGFloat delta = ABS(attrs.center.x - centenrx);
        
        //根据间距值，计算cell的缩放比例
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
        
        //设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return arr;
    
}

//一旦重新布局，就会重新调用layoutAttributesForElementsInRect
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//这个方法的返回值决定了collectionview停止滚动时候的偏移量（即将停止滚动的时候调用）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x =proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    //这里建议调用super,因为用self会把里面for循环的transform再算一遍,但我们仅仅想拿到中心点X,super中已经算好中心点X的值了
    NSArray *array =[super layoutAttributesForElementsInRect:rect];
    //计算collectionView最中心点的X的值
    /*
     proposedContentOffset 目的,原本
     拿到最后这个偏移量的X,最后这些cell,距离最后中心点的位置
     */
    CGFloat centerX = proposedContentOffset.x +self.collectionView.frame.size.width*0.5;
    
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if ((ABS(minDelta)>ABS(attrs.center.x - centerX))) {
            minDelta = attrs.center.x - centerX;
        } ;
    }
    //修改原有的偏移量
    proposedContentOffset.x +=minDelta;
    
    return proposedContentOffset;

}
@end
