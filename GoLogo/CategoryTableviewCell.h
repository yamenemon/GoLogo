//
//  CategoryTableviewCell.h
//  GoLogo
//
//  Created by CSM on 3/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *catergoryDetails;

@end
