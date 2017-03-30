//
//  ProductTableViewCell.m
//  GoLogo
//
//  Created by CSM on 3/28/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell
@synthesize  productImage;
@synthesize productName;
@synthesize productDescription;
@synthesize salesLabel;
@synthesize retailLabel;
@synthesize salesPrice;
@synthesize retailPrice;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    salesLabel.text = @"Sales Price:";
    retailLabel.text = @"Retail Price:";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
