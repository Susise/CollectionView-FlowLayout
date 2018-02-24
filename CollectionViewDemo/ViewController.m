//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by S on 2018/2/24.
//  Copyright © 2018年 S. All rights reserved.
//

#import "ViewController.h"
#import "ZWCollectionViewFlowLayout.h"
#import "CollectionCell.h"
#import "CustomFlowLayout.h"

static NSString *iden = @"celliden";


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZWwaterFlowDelegate>

@property ( nonatomic,strong ) UICollectionView *collectionView;

@property ( nonatomic,strong ) ZWCollectionViewFlowLayout *flowLayout;

@property ( nonatomic,strong ) CustomFlowLayout *customFlowLayout;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"CollectionViewDemo";
    
    [self.view addSubview:self.collectionView];
    
    
}
#pragma mark -- delegate datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

#pragma mark -- flowlayout delegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach{
    return 250;
}
#pragma mark -- 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300) collectionViewLayout:self.customFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor orangeColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:iden];
    }
    return _collectionView;
}
- (ZWCollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
        _flowLayout.degelate = self;
        _flowLayout.colCount = 1;
        _flowLayout.colMagrin = 10;
        _flowLayout.rowMagrin = 20;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _flowLayout;
}
- (CustomFlowLayout *)customFlowLayout{
    if (!_customFlowLayout) {
        _customFlowLayout = [[CustomFlowLayout alloc] init];
        _customFlowLayout.itemSize = CGSizeMake( 100, 250);
        _customFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    }
    return _customFlowLayout;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
