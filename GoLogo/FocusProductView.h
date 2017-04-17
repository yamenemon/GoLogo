//
//  FocusProductView.h
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "CompanyInfoObject.h"
@interface FocusProductView : UIView
@property (strong, nonatomic) CompanyViewController *baseController;
@property (strong, nonatomic) CompanyInfoObject *companyInfoObject;
@end
