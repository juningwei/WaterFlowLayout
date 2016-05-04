//
//  ViewController.m
//  WaterFlowLayout
//
//  Created by 鞠凝玮 on 16/2/25.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "MJRefresh.h"
#import "Shop.h"
#import "MJExtension.h"
#import "ShopCell.h"
@interface ViewController ()<UICollectionViewDataSource, WaterFlowDelegate>
@property (nonatomic, strong)NSMutableArray *shops;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)WaterFlowLayout *waterFlowLayout;
@end

@implementation ViewController

-(NSMutableArray *)shops{
    if (!_shops){
        _shops = [NSMutableArray new];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
    [self setupRefresh];
}

- (void)setupLayout{
    WaterFlowLayout *waterFlowLayout = [[WaterFlowLayout alloc]init];
    waterFlowLayout.delegate = self;
    UICollectionView *collectionView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterFlowLayout];
    self.waterFlowLayout = waterFlowLayout;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:@"shop"];
    self.collectionView = collectionView;
}

- (void)setupRefresh{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
}

- (void)loadNewShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"]];
        NSArray *shops = [Shop objectArrayWithKeyValuesArray:arr];
        
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        [self.collectionView reloadData];
        
        [self.collectionView.header endRefreshing];

    });
}

- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"]];
        NSArray *shops = [Shop objectArrayWithKeyValuesArray:arr];
        [self.shops addObjectsFromArray:shops];

        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];

    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

-(CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    Shop *shop = self.shops[index];
    CGFloat cellHeight = itemWidth * shop.h / shop.w;
    return cellHeight;
}

//-(CGFloat)RowMarginInWaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout{
//    return 20;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
