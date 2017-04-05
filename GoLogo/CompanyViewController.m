//
//  CompanyViewController.m
//  GoLogo
//
//  Created by CSM on 4/3/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CompanyViewController.h"
#define COMPANY_URL @"http://www.amadersolution.com/APItest/readCompanyListMySQLiUpload2.php"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CompanyViewController ()
{
    NSMutableArray *productArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UITextView *companyInfoTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewImageView;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipLabel;
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
    myManager = [MyManager sharedManager];
}
-(void)viewWillAppear:(BOOL)animated{
    self.title = @"GoLogo";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x01A1DF);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Futura" size:20.0]}];
}
-(void)viewDidLayoutSubviews{
    if (myManager.companyInfoArray.count == 0) {
        [self loadCompanyInfoData];
    }
    else{
        [productArray addObject:myManager.companyInfoArray];
    }
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
//                        [productArray addObject:companyInfoObject];
                    }
                    NSLog(@"product array: %@",productArray);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view setNeedsDisplay];
                        [self createViewsWithInfo];
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
-(void)createViewsWithInfo{

    _companyName.text = companyInfoObject.companyName;
    _companyInfoTextView.text = companyInfoObject.companyBio;
    _streetLabel.text = companyInfoObject.street;
    _cityLabel.text = companyInfoObject.city;
    _stateLabel.text = companyInfoObject.state;
    _zipLabel.text = companyInfoObject.zip;

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
