//
//  CatalogViewController.m
//  GoLogo
//
//  Created by CSM on 1/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CatalogViewController.h"
#import "AppDelegate.h"
#import <SVProgressHUD.h>
#import "CategoryTableviewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  CategoryDataURL @"http://amadersolution.com/APItest/catalog_appPDO/readCategoryListMySQLi.php"
@interface CatalogViewController (){

    NSMutableArray *productArray;
    CategoryJsonObject *catergoryObject;
    UIRefreshControl *refreshControl;

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
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = UIColorFromRGB(0xFBE3BF);
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                            action:@selector(reloadTableDataAtCatalog)
                  forControlEvents:UIControlEventValueChanged];
    [_categoryTableView addSubview:refreshControl];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = @"Category";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x01A1DF);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Futura" size:22.0]}];
}
- (void)reloadTableDataAtCatalog
{
    // Reload table data

    [_categoryTableView reloadData];

    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
}
-(void)viewDidLayoutSubviews{
    _categoryTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self loadData];
}
-(void)loadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        [self loadCatergoryTableViewData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_categoryTableView reloadData];
            [SVProgressHUD dismiss];
        });
    });
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
                            
                             /*
                             "id": "8",
                             "companyId": "0",
                             "categoryName": "Demo 3",
                             "icon": "8.jpg",
                             "description": "Demo",
                             "parent": "1",
                             */
                            
                            catergoryObject = [[CategoryJsonObject alloc] init];
                            catergoryObject.companyId = [jsonArray[i] objectForKey:@"categoryld"];
                            catergoryObject.categoryName = [jsonArray[i] objectForKey:@"categoryName"];
                            catergoryObject.categoryDescription = [jsonArray[i] objectForKey:@"description"];
                            catergoryObject.icon = [jsonArray[i] objectForKey:@"icon"];
                            catergoryObject.parent = [jsonArray[i] objectForKey:@"parent"];
                            [productArray addObject:catergoryObject];
                        }
                        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (productArray.count>0) {
        
        _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _categoryTableView.backgroundView.hidden = YES;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        _categoryTableView.backgroundView = messageLabel;
        _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
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
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",@"http://amadersolution.com/APItest/catalog_appPDO/upload/category",catergoryObject.icon];
    NSLog(@"image Url: %@",baseUrl);
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:baseUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.categoryName.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryName];
    cell.catergoryDetails.text = [NSString stringWithFormat:@"%@",catergoryObject.categoryDescription];
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
