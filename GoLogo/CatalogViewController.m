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
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    productArray = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString* tokenAsString = [appDelegate deviceToken];
}
-(void)viewDidLayoutSubviews{
//    [self createThumbScroller];
    [self loadCatergoryTableViewData];
}

-(void)loadCatergoryTableViewData{
    NSLog(@"%@",CategoryDataURL);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:CategoryDataURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                if (data) {
                    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error: &error];
//                    "id":"2",
//                    "companyId":"1",
//                    "categoryName":"cap",
//                    "icon":"cap.jpg",
//                    "description":"this is about shirt",
//                    "createDate":"2017-03-21 22:28:38",
//                    "modifyDate":"0000-00-00 00:00:00"
                    for (int i=0; i<jsonArray.count; i++) {
                        catergoryObject = [[CategoryJsonObject alloc] init];
                        catergoryObject.companyId = [jsonArray[i] objectForKey:@"categoryld"];
                        catergoryObject.categoryName = [jsonArray[i] objectForKey:@"categoryName"];
                        catergoryObject.categoryDescription = [jsonArray[i] objectForKey:@"description"];
                        catergoryObject.icon = [jsonArray[i] objectForKey:@"icon"];
                        [productArray addObject:catergoryObject];
                    }
                    NSLog(@"product array: %@",productArray);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_categoryTableView reloadData];
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
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }];
                    [alertView setValue:UIColorFromRGB(0x0A5A78) forKey:@"titleTextColor"];
                    
                    [alertController addAction:alertView];
                }
                
            }] resume];
    

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
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",@"http://amadersolution.com/APItest/images/category",catergoryObject.icon];
    NSLog(@"Base Url: %@",baseUrl);
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:baseUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.categoryName.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryName];
    cell.catergoryDetails.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryDescription];
    [cell.catergoryDetails setNumberOfLines:0];
    [cell.catergoryDetails sizeToFit];
    [cell setNeedsLayout];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    ProductViewController *productVC = [[ProductViewController alloc] init];
//    [self.navigationController pushViewController:productVC animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"productVC"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:vc animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}
@end
