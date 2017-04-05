//
//  ProductViewController.m
//  GoLogo
//
//  Created by CSM on 3/28/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ProductViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  CategoryDataURL @"http://amadersolution.com/APItest/readProductListMySQLi2.php"

@interface ProductViewController (){

    NSMutableArray *productArray;
    ProductJsonObject *productObject;
}
@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArray = [[NSMutableArray alloc] init];

}
-(void)viewWillAppear:(BOOL)animated{
    self.title = @"Catalog Products";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x01A1DF);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Futura" size:20.0]}];
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString* tokenAsString = [appDelegate deviceToken];
}
-(void)viewDidLayoutSubviews{
    //    [self createThumbScroller];
    [self loadProductTableViewData];
}

-(void)loadProductTableViewData{
//    NSLog(@"%@",CategoryDataURL);
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
                         "id":"5",
                         "categoryld":"5",
                         "productName":"Testing Product",
                         "description":"Testing Product details",
                         "photo":"5.jpg",
                         "link":"",
                         "token":"",
                         "price":"0.00",
                         "retailPrice":"0.00",
                         "salePrice":"0.00",
                         "createDate":"2017-03-29 13:32:08",
                         "lastModifiedDate":"0000-00-00 00:00:00"
                         */
                        productObject = [[ProductJsonObject alloc] init];
                        productObject.categoryld = [jsonArray[i] objectForKey:@"categoryld"];
                        productObject.productName = [jsonArray[i] objectForKey:@"productName"];
                        productObject.productDescription = [jsonArray[i] objectForKey:@"description"];
                        productObject.photo = [jsonArray[i] objectForKey:@"photo"];
                        productObject.price = [jsonArray[i] objectForKey:@"price"];
                        productObject.retailPrice = [jsonArray[i] objectForKey:@"retailPrice"];
                        productObject.salePrice = [jsonArray[i] objectForKey:@"salePrice"];
                        [productArray addObject:productObject];
                    }
                    NSLog(@"product array: %@",productArray);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_productTableView reloadData];
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
                                                 [self loadProductTableViewData];
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
    NSString *cellIdentifier = @"ProductCell";
    ProductTableViewCell *cell = (ProductTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    productObject = [productArray objectAtIndex:indexPath.row];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",@"http://amadersolution.com/APItest/upload/product",productObject.photo];
//    NSLog(@"Base Url: %@",baseUrl);
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString:baseUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.productName.text = [NSString stringWithFormat:@"%@",productObject.productName];
    cell.productDescription.text = [NSString stringWithFormat:@"%@",productObject.productDescription];
    [cell.productDescription setNumberOfLines:2];
//    [cell.productDescription sizeToFit];
    
    cell.salesPrice.text = [NSString stringWithFormat:@"%@",productObject.salePrice];
    cell.retailPrice.text = [NSString stringWithFormat:@"%@",productObject.retailPrice];
    
    [cell setNeedsLayout];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProductDetailsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ProductDetailsVC"];
    vc.productJsonObject = [productArray objectAtIndex:indexPath.row];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
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
