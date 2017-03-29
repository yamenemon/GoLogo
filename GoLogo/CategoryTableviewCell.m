//
//  CategoryTableviewCell.m
//  GoLogo
//
//  Created by CSM on 3/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CategoryTableviewCell.h"

@implementation CategoryTableviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // Tell the label to use an unlimited number of lines
    [_catergoryDetails setNumberOfLines:0];
    [_catergoryDetails sizeToFit];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
