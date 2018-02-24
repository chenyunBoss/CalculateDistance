//
//  PBLViewController.m
//  TEST
//
//  Created by chenyun on 2017/10/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PBLViewController.h"
#import "PBLLayout.h"
#import "HeaderView.h"
#import "FooterView.h"

@interface PBLViewController () <PBLLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *heightArray;

@end

@implementation PBLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.heightArray = @[@(50), @(60), @(70), @(80), @(90), @(100), @(110), @(120), @(130), @(140),];
    PBLLayout *layout = [[PBLLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
//    layout.headerReferenceSize = CGSizeMake(50, 50);
//    layout.footerReferenceSize = CGSizeMake(50, 50);
    [self.view addSubview:self.collectionView];
}

- (CGFloat)waterflowLayout:(PBLLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    return 50 + arc4random_uniform(120);
//    return [self.heightArray[index] floatValue];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderView *headerView = (HeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor greenColor];
        return headerView;
    } else { // 返回每一组的尾部视图
        FooterView *footerView =  (FooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footerView.backgroundColor = [UIColor purpleColor];
        return footerView;
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(self.view.frame.size.width, 50);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(self.view.frame.size.width, 50);
//}

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
 }- (CGFloat)waterflowLayout:(PBLLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
 <#code#>
 }
 
 - (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
 <#code#>
 }
 
 - (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
 <#code#>
 }
 
 - (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 <#code#>
 }
 
 - (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
 <#code#>
 }
 
 - (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 <#code#>
 }
 
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 <#code#>
 }
 
 - (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 <#code#>
 }
 
 - (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
 <#code#>
 }
 
 - (void)setNeedsFocusUpdate {
 <#code#>
 }
 
 - (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
 <#code#>
 }
 
 - (void)updateFocusIfNeeded {
 <#code#>
 }
 
 
*/

@end
