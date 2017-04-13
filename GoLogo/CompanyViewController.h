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
#import <MessageUI/MessageUI.h>
@interface CompanyViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    MFMailComposeViewController *mailComposer;
    CompanyInfoObject *companyInfoObject;
    MyManager *myManager;
}
-(void)callingBtnAction:(id)sender;
-(void)websiteBtnAction:(id)sender;
- (void)emailBtnAction:(id)sender;
@end
