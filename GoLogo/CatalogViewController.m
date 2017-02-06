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
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArray = [[NSMutableArray alloc] initWithObjects:@"1.png",@"2.png",@"3.png",nil];
    [self setupScrollView];
}
-(void) setupScrollView {
    //add the scrollview to the view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    //setup internal views
    NSInteger numberOfViews = productArray.count;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"Catalog%d", i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:image];
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             numberOfViews,
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
}

@end
