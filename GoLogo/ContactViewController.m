//
//  ContactViewController.m
//  GoLogo
//
//  Created by CSM on 2/6/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ContactViewController.h"
#define COMPANY_URL @"http://www.amadersolution.com/APItest/readCompanyListMySQLiUpload2.php"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UIButton *callingImage;
@property (weak, nonatomic) IBOutlet UIButton *emailImage;
@property (weak, nonatomic) IBOutlet UIButton *websiteImage;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{

    [self shakeView];
    [self shakeEmail];
    [self shakeWebsite];
}
-(void)viewDidLayoutSubviews{
        [self loadCompanyInfoData];
}
-(void)loadCompanyInfoData{
    NSLog(@"%@",COMPANY_URL);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:COMPANY_URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                if (data) {
                    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error: &error];
                    
                    for (int i=0; i<jsonArray.count; i++) {
                        /*
                         "id":"5",
                         "companyName":"GoLogo",
                         "street":"GoLogo Street",
                         "city":"Demo City",
                         "state":"AK",
                         "zip":"1230",
                         "phone":"8801841664",
                         "contactName":"GoLogo",
                         "contactEmail":"GoLogoo@GoLogo.com",
                         "companyBio":"GoLogoGoLogoGoLogoGoLogo",
                         "companyLogo":"5.png",
                         "companyWebsite":"https:\/\/GoLogo.com\/",
                         "note":"",
                         "createDate":"2017-04-04 12:53:14",
                         "lastModifiedDate":"0000-00-00 00:00:00"
                         */
                        
                        companyInfoObject = [[CompanyInfoObject alloc] init];
                        companyInfoObject.companyName = [jsonArray[i] objectForKey:@"companyName"];
                        companyInfoObject.street = [jsonArray[i] objectForKey:@"street"];
                        companyInfoObject.city = [jsonArray[i] objectForKey:@"city"];
                        companyInfoObject.state = [jsonArray[i] objectForKey:@"state"];
                        companyInfoObject.zip = [jsonArray[i] objectForKey:@"zip"];
                        companyInfoObject.phone = [jsonArray[i] objectForKey:@"phone"];
                        companyInfoObject.contactEmail = [jsonArray[i] objectForKey:@"contactEmail"];
                        companyInfoObject.companyBio = [jsonArray[i] objectForKey:@"companyBio"];
                        companyInfoObject.companyLogo = [jsonArray[i] objectForKey:@"companyLogo"];
                        companyInfoObject.companyWebsite = [jsonArray[i] objectForKey:@"companyWebsite"];
                        companyInfoObject.note = [jsonArray[i] objectForKey:@"note"];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view setNeedsDisplay];
                    });
                    if (error) {
                        NSLog(@"Json Parse Error");
                    }
                }
                else{
                    NSLog(@"Data Not found");
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                              message: nil
                                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *alertView =  [UIAlertAction actionWithTitle: @"Error!!!" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        UIAlertController * alert=   [UIAlertController
                                                      alertControllerWithTitle:@"No Data Found"
                                                      message:@"Reload?"
                                                      preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* ok = [UIAlertAction
                                             actionWithTitle:@"OK"
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action)
                                             {
                                                 //                                                 [self loadCatergoryTableViewData];
                                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                                 
                                             }];
                        UIAlertAction* cancel = [UIAlertAction
                                                 actionWithTitle:@"Cancel"
                                                 style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                                                 {
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                 }];
                        [alert addAction:ok];
                        [alert addAction:cancel];
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }];
                    //                    [alertView setValue:UIColorFromRGB(0x0A5A78) forKey:@"titleTextColor"];
                    
                    [alertController addAction:alertView];
                }
                
            }] resume];
}
-(void)shakeWebsite{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.2];
    [shake setRepeatCount:5.0];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(_websiteImage.center.x,_websiteImage.center.y+5)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(_websiteImage.center.x, _websiteImage.center.y-5)]];
    [_websiteImage.layer addAnimation:shake forKey:@"position"];
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
    [mailComposer setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",companyInfoObject.companyWebsite], nil]];
    [mailComposer setSubject:@"Feedback Email"];
    [mailComposer setMessageBody:@"" isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
    
}
- (IBAction)websiteBtnAction:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",companyInfoObject.companyWebsite]];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
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
