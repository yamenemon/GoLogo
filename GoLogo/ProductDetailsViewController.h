//
//  ProductDetailsViewController.h
//  GoLogo
//
//  Created by CSM on 3/31/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductJsonObject.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ProductDetailsViewController : UIViewController
@property (strong, nonatomic) ProductJsonObject *productJsonObject;
@property (weak, nonatomic) IBOutlet UIImageView *productDetailImageView;
@property (weak, nonatomic) IBOutlet UIButton *addToCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *favbtn;

@property (weak, nonatomic) IBOutlet UIScrollView *productInfoScrollView;
@end
