//
//  CompanyViewController.h
//  GoLogo
//
//  Created by CSM on 4/3/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyInfoObject.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyManager.h"
@interface CompanyViewController : UIViewController{
    CompanyInfoObject *companyInfoObject;
    MyManager *myManager;
}

@end
