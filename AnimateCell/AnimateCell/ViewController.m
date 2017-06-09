//
//  ViewController.m
//  AnimateCell
//
//  Created by idaoben idaoben on 2017/6/9.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "ViewController.h"

@interface KGeCell : UICollectionViewCell
@property (nonatomic) UILabel *titleLb;
@end
@implementation KGeCell
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
        [self.contentView addSubview:_titleLb];
    }
    return _titleLb;
}

@end



//UICollectionViewDelegateFlowLayout个性化定制每个section的样式
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) NSArray *dataList;
//起始显示的数量
@property (nonatomic) NSInteger currentCount;

@property (nonatomic) NSTimer *timer;
@end

@implementation ViewController


- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableArray *tmpArr = [NSMutableArray new];
        for (int i = 0; i < 100; i++) {
            [tmpArr addObject:@(i)];
        }
        _dataList = tmpArr.copy;
    }
    return _dataList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _currentCount = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[KGeCell class] forCellWithReuseIdentifier:@"KGeCell"];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _currentCount++;
        [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
        if (_currentCount == self.dataList.count) {
            [_timer invalidate];
            _timer = nil;
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.bounds.size.width, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _currentCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KGeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KGeCell" forIndexPath:indexPath];
    //indexPath.row 0~9    要获取共100个元素数组中的 90 ~ 99条
    NSInteger row = self.dataList.count - _currentCount + indexPath.row;
    cell.titleLb.text = [self.dataList[row] stringValue];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    //点击之后的背景图
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = bgView;
    return cell;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

