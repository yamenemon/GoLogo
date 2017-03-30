//
//  ProductTableViewCell.h
//  GoLogo
//
//  Created by CSM on 3/28/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *retailLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesPrice;
@property (weak, nonatomic) IBOutlet UILabel *retailPrice;

@end
