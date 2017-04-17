//
//  TaglineView.h
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyInfoObject.h"
#import "CompanyViewController.h"
@interface TaglineView : UIView
@property (strong, nonatomic) CompanyViewController *baseController;
@property (strong, nonatomic) CompanyInfoObject *companyInfoObject;
@property (weak, nonatomic) IBOutlet UILabel *tagHeaderLabel;
@property (weak, nonatomic) IBOutlet UITextView *tagDescriptionTextView;

-(void)loadTaglines;
@end
