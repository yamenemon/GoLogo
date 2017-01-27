//
//  CatalogViewController.m
//  GoLogo
//
//  Created by CSM on 1/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CatalogViewController.h"

@interface CatalogViewController (){

    NSMutableArray *productArray;

}
@property (weak, nonatomic) IBOutlet UICollectionView *catalogCollectionView;

@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArray = [[NSMutableArray alloc] initWithObjects:@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",@"11.png",
                    @"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",@"21.png",@"22.png",nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return productArray.count-1;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[productArray objectAtIndex:indexPath.row]];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    [self.view addSubview:recipeImageView];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[productArray objectAtIndex:indexPath.row+1]]]];
    backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundView = backgroundView;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[productArray objectAtIndex:indexPath.row+1]]];
    return CGSizeMake(135, 130);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
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
