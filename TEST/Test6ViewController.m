//
//  Test6ViewController.m
//  TEST
//
//  Created by chenyun on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#define cellPadding 5
#define cellSpace 60
#define cellHeight 80

#import "Test6ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "CollectionViewCell.h"

@interface Test6ViewController () <MAMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate> {
    NSInteger current;
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation Test6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
//
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;

    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;

    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;

    commonPolylineCoords[3].latitude = 39.911136;
    commonPolylineCoords[3].longitude = 116.48095;

    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];

    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];

    MAPointAnnotation *start = [[MAPointAnnotation alloc] init];
    start.coordinate = commonPolylineCoords[0];
    start.title = @"start";

    MAPointAnnotation *end = [[MAPointAnnotation alloc] init];
    end.coordinate = commonPolylineCoords[3];
    end.title = @"end";

    [self.mapView addAnnotations:@[start, end]];
    [self.mapView showAnnotations:@[start, end] animated:YES];
    
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:@[@"1", @"0", @"0", @"0"]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - cellHeight, self.view.frame.size.width, cellHeight) collectionViewLayout:flowLayout];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 5.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
//        polylineRenderer.strokeImage = [UIImage imageNamed:@"custtexture"];
        polylineRenderer.lineDash = YES;
        return polylineRenderer;
    }
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = NO;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        if ([[annotation title] isEqualToString:@"end"]){
            annotationView.image = [UIImage imageNamed:@"finish"];
        }
        else if ([[annotation title] isEqualToString:@"start"]) {
            annotationView.image = [UIImage imageNamed:@"starter"];
        }
        
        return annotationView;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    if (indexPath.item == 0) {
//        cell.backgroundColor = [UIColor redColor];
//    } else if (indexPath.item == 1) {
//        cell.backgroundColor = [UIColor greenColor];
//    } else if (indexPath.item == 2) {
//        cell.backgroundColor = [UIColor orangeColor];
//    } else {
//        cell.backgroundColor = [UIColor blueColor];
//    }
    cell.value = self.dataSource[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = self.view.frame.size.width - (cellSpace + cellPadding) * 2;
    CGFloat cellContentOffsetX = cellWidth + cellPadding;
    [self.collectionView setContentOffset:CGPointMake(indexPath.item * cellContentOffsetX , 0) animated:YES];
    [self.dataSource enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) {
            [self.dataSource replaceObjectAtIndex:idx withObject:@"0"];
        }
    }];
    [self.dataSource replaceObjectAtIndex:indexPath.item withObject:@"1"];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width - (cellSpace + cellPadding) * 2;
    return CGSizeMake(width, cellHeight);
}

// 分区四边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, cellPadding + cellSpace, 0, cellPadding + cellSpace);
}

// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return cellPadding;
}

// 手指停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollCell];
    }
}

// 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollCell];
}

- (void)scrollCell {
    CGFloat cellWidth = self.view.frame.size.width - (cellPadding + cellSpace) * 2;
    // 单个cell需要滚动的距离
    CGFloat cellContentOffsetX = cellWidth + cellPadding;
    NSInteger page = (self.collectionView.contentOffset.x) / cellContentOffsetX + 0.5;
//    [self.collectionView setContentOffset:CGPointMake(page * cellContentOffsetX , 0) animated:NO];
    // 全部置为原始状态
    [self.dataSource enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) {
            [self.dataSource replaceObjectAtIndex:idx withObject:@"0"];
        }
    }];
    [self.dataSource replaceObjectAtIndex:page withObject:@"1"];
    [self.collectionView reloadData];
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self.collectionView setContentOffset:CGPointMake(page * cellContentOffsetX , 0) animated:NO];
//    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
