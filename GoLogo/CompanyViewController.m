//
//  CompanyViewController.m
//  GoLogo
//
//  Created by CSM on 4/3/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CompanyViewController.h"
#define COMPANY_URL @"http://www.amadersolution.com/APItest/readCompanyListMySQLiUpload2.php"
@interface CompanyViewController ()
{
    NSMutableArray *productArray;
}
@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    productArray = [[NSMutableArray alloc] init];
    
}
-(void)viewDidLayoutSubviews{
    //    [self createThumbScroller];
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
                        companyInfoObject.city = [jsonArray[i] objectForKey:@"city"];
                        companyInfoObject.state = [jsonArray[i] objectForKey:@"state"];
                        companyInfoObject.zip = [jsonArray[i] objectForKey:@"zip"];
                        companyInfoObject.companyBio = [jsonArray[i] objectForKey:@"companyBio"];
                        companyInfoObject.companyLogo = [jsonArray[i] objectForKey:@"companyLogo"];
                        companyInfoObject.companyLogo = [jsonArray[i] objectForKey:@"companyLogo"];
                        [productArray addObject:companyInfoObject];
                    }
                    NSLog(@"product array: %@",productArray);
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
