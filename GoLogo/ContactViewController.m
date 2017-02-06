//
//  ContactViewController.m
//  GoLogo
//
//  Created by CSM on 2/6/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UIButton *callingImage;
@property (weak, nonatomic) IBOutlet UIButton *emailImage;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{

    [self shakeView];
    [self shakeEmail];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)shakeView {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.2];
    [shake setRepeatCount:5.0];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(_callingImage.center.x - 5,_callingImage.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(_callingImage.center.x + 5, _callingImage.center.y)]];
    [_callingImage.layer addAnimation:shake forKey:@"position"];
}
-(void)shakeEmail{

    CABasicAnimation *shakeEmail = [CABasicAnimation animationWithKeyPath:@"position"];
    [shakeEmail setDuration:0.2];
    [shakeEmail setRepeatCount:5.0];
    [shakeEmail setAutoreverses:YES];
    [shakeEmail setFromValue:[NSValue valueWithCGPoint:
                              CGPointMake(_emailImage.center.x + 5,_emailImage.center.y)]];
    [shakeEmail setToValue:[NSValue valueWithCGPoint:
                            CGPointMake(_emailImage.center.x - 5, _emailImage.center.y)]];
    [_emailImage.layer addAnimation:shakeEmail forKey:@"position"];

}
- (IBAction)callingBtnAction:(id)sender {
    NSString *phNo = @"+888-533-2863";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
       //
    }
}
- (IBAction)emailBtnAction:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:[NSArray arrayWithObjects:@"bobbi@centralscreenprinting.com", nil]];
    [mailComposer setSubject:@"Feedback Email"];
    [mailComposer setMessageBody:@"" isHTML:NO];
     [self presentViewController:mailComposer animated:YES completion:nil];
     }
     
#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
       didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
       if (result) {
          NSLog(@"Result : %ld",(long)result);
       }
       if (error) {
          NSLog(@"Error : %@",error);
       }
      [self dismissViewControllerAnimated:YES completion:nil];
}
    /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
