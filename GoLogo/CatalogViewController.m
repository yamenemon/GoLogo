//
//  CatalogViewController.m
//  GoLogo
//
//  Created by CSM on 1/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CatalogViewController.h"
#import "AppDelegate.h"

#import "CategoryTableviewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  CategoryDataURL @"http://amadersolution.com/APItest/readCategoryListMySQLi2.php"
@interface CatalogViewController (){

    NSMutableArray *productArray;
    CategoryJsonObject *catergoryObject;

}
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation CatalogViewController

#pragma mark UIViewController Delegate -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArray = [[NSMutableArray alloc] init];
    [MTReachabilityManager sharedManager];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = @"Catalog";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x01A1DF);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Futura" size:22.0]}];

    
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString* tokenAsString = [appDelegate deviceToken];
}
-(void)viewDidLayoutSubviews{
    [self loadCatergoryTableViewData];
    NSLog(@"Not Reachable");
}

-(void)loadCatergoryTableViewData{
//    NSLog(@"%@",CategoryDataURL);
    if ([MTReachabilityManager isReachable]) {
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:CategoryDataURL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    // handle response
                    if (data) {
                        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error: &error];
                        
                        for (int i=0; i<jsonArray.count; i++) {
                            catergoryObject = [[CategoryJsonObject alloc] init];
                            catergoryObject.companyId = [jsonArray[i] objectForKey:@"categoryld"];
                            catergoryObject.categoryName = [jsonArray[i] objectForKey:@"categoryName"];
                            catergoryObject.categoryDescription = [jsonArray[i] objectForKey:@"description"];
                            catergoryObject.icon = [jsonArray[i] objectForKey:@"icon"];
                            [productArray addObject:catergoryObject];
                        }
                        //                    NSLog(@"product array: %@",productArray);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_categoryTableView reloadData];
                        });
                        if (error) {
                            NSLog(@"Json Parse Error");
                        }
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"Data Not found");
                            UIAlertController * alert=   [UIAlertController
                                                          alertControllerWithTitle:@"No Data Found"
                                                          message:@"Reload?"
                                                          preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* ok = [UIAlertAction
                                                 actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                                                 {
                                                     [self loadCatergoryTableViewData];
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
                            [ok setValue:UIColorFromRGB(0x0A5A78) forKey:@"titleTextColor"];
                            [cancel setValue:UIColorFromRGB(0x0A5A78) forKey:@"titleTextColor"];
                            [self presentViewController:alert animated:YES completion:nil];
                        });
                    }
                }] resume];
    }
    else{
        NSLog(@"Not Reachable");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Internet Problem" message:@"You are out of network.Prese check your network settings." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        [alert addAction:ok];
        [ok setValue:UIColorFromRGB(0x0A5A78) forKey:@"titleTextColor"];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return productArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    CategoryTableviewCell *cell = (CategoryTableviewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableviewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    catergoryObject = [productArray objectAtIndex:indexPath.row];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",@"http://amadersolution.com/APItest/upload/category",catergoryObject.icon];
//        NSLog(@"Base Url: %@",baseUrl);
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:baseUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.categoryName.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryName];
    cell.catergoryDetails.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryDescription];
//    cell.catergoryDetails.numberOfLines = 0;
//    cell.catergoryDetails.frame = CGRectMake(cell.catergoryDetails.frame.origin.x,cell.catergoryDetails.frame.origin.x,200,800);
//    [cell.catergoryDetails sizeToFit];
//    [cell setNeedsLayout];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"productVC"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:vc animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}
@end
