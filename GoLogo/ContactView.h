//
//  ContactView.h
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyInfoObject.h"

@class CompanyViewController;

@interface ContactView : UIView

@property (weak, nonatomic) IBOutlet UIButton *callingImage;
@property (weak, nonatomic) IBOutlet UIButton *emailImage;
@property (weak, nonatomic) IBOutlet UIButton *websiteImage;
@property (strong, nonatomic) CompanyViewController *baseController;
@property (strong, nonatomic) CompanyInfoObject *companyInfoObject;
@end
