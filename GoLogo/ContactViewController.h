//
//  ContactViewController.h
//  GoLogo
//
//  Created by CSM on 2/6/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *mailComposer;
}
@end
