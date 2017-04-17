//
//  CompanyViewController.m
//  GoLogo
//
//  Created by CSM on 4/3/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "CompanyViewController.h"
#import "iCarousel.h"
#import "ContactView.h"
#import "GeoLocation.h"
#import "TaglineView.h"
#import "FocusProductView.h"
#import "FacilitiesView.h"

#define COMPANY_URL @"http://www.amadersolution.com/APItest/readCompanyListMySQLiUpload2.php"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CompanyViewController ()<iCarouselDelegate,iCarouselDataSource>
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

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myManager = [MyManager sharedManager];
}
-(void)viewWillAppear:(BOOL)animated{
    self.title = @"GoLogo";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x01A1DF);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Futura" size:20.0]}];
    [self loadCompanyInfoData];

}
-(void)viewDidLayoutSubviews{
//    if (myManager.companyInfoArray.count == 0) {
//        [self loadCompanyInfoData];
//    }
//    else{
//        [productArray addObject:myManager.companyInfoArray];
//    }
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
                         city = "New York";
                         companyBio = "Year;Make;Model;Length
                         \n1997;Ford;E350;2,34
                         \n2000;Mercury;Cougar;2,38";
                         companyLogo = "12.png";
                         companyName = GoLogo;
                         companyWebsite = "www.centralscreenprinting.com";
                         contactEmail = "bobbi@centralscreenprinting.com";
                         contactName = Bobbi;
                         createDate = "2017-04-12 17:48:36";
                         facilities = "Year;Make;Model;Length
                         \n1997;Ford;E350;2,34
                         \n2000;Mercury;Cougar;2,38";
                         focusProdcut = "Year;Make;Model;Length
                         \n1997;Ford;E350;2,34
                         \n2000;Mercury;Cougar;2,38";
                         geoLocation = "32.8203525,-97.0115281";
                         id = 12;
                         lastModifiedDate = "0000-00-00 00:00:00";
                         note = "";
                         phone = 8885332863;
                         state = AK;
                         street = Alaska;
                         tagLine = "Year;Make;Model;Length 1997;Ford;E350;2,34 2000;Mercury;Cougar;2,38";
                         zip = 123210;
                         */
                        
                        companyInfoObject = [[CompanyInfoObject alloc] init];
                        companyInfoObject.companyName = [jsonArray[i] objectForKey:@"companyName"];
                        companyInfoObject.street = [jsonArray[i] objectForKey:@"street"];
                        companyInfoObject.city = [jsonArray[i] objectForKey:@"city"];
                        companyInfoObject.state = [jsonArray[i] objectForKey:@"state"];
                        companyInfoObject.zip = [jsonArray[i] objectForKey:@"zip"];
                        companyInfoObject.phone = [jsonArray[i] objectForKey:@"phone"];
                        companyInfoObject.contactEmail = [jsonArray[i] objectForKey:@"contactEmail"];
                        companyInfoObject.companyName = [jsonArray[i] objectForKey:@"contactName"];
                        companyInfoObject.companyBio = [jsonArray[i] objectForKey:@"companyBio"];
                        companyInfoObject.companyLogo = [jsonArray[i] objectForKey:@"companyLogo"];
                        companyInfoObject.companyWebsite = [jsonArray[i] objectForKey:@"companyWebsite"];
                        companyInfoObject.facilities = [jsonArray [i] objectForKey:@"facilities"];
                        companyInfoObject.focusProdcut = [jsonArray [i] objectForKey:@"focusProdcut"];
                        companyInfoObject.geoLocation = [jsonArray[i] objectForKey:@"geoLocation"];
                        companyInfoObject.tagLine = [jsonArray [i] objectForKey:@"tagLine"];
                        companyInfoObject.note = [jsonArray[i] objectForKey:@"note"];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self createViewsWithInfo];
                    });
                    if (error) {
                        NSLog(@"Json Parse Error");
                    }
                }
                else{
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
                                             [self loadCompanyInfoData];
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
                }
                
            }] resume];
}
-(void)createCarousel{

    ContactView * contactView = [[[NSBundle mainBundle] loadNibNamed:@"ContactView" owner:self options:nil] lastObject];
    contactView.companyInfoObject = companyInfoObject;
    contactView.baseController = self;
//    GeoLocation *geoView = [[GeoLocation alloc] init];
    NSArray *strings = [companyInfoObject.geoLocation componentsSeparatedByString:@","];
    
    GeoLocation *geoView = [[[NSBundle mainBundle] loadNibNamed:@"GeoLocation" owner:self options:nil] lastObject];
    geoView.latitude = [[strings objectAtIndex:0] doubleValue];
    geoView.longitude = [[strings objectAtIndex:1] doubleValue];
    [geoView loadMap];
    
    TaglineView * tagView = [[[NSBundle mainBundle] loadNibNamed:@"TaglineView" owner:self options:nil] lastObject];
    tagView.companyInfoObject = companyInfoObject;
    tagView.baseController = self;
    [tagView loadTaglines];
    
    FocusProductView * focusView = [[[NSBundle mainBundle] loadNibNamed:@"FocusProductView" owner:self options:nil] lastObject];
    FacilitiesView * facilitiesView = [[[NSBundle mainBundle] loadNibNamed:@"FacilitiesView" owner:self options:nil] lastObject];
    
    contactView.bounds = CGRectMake(0, 0, self.carouselView.bounds.size.width - 5, self.carouselView.bounds.size.height - 5);
    geoView.bounds = CGRectMake(0, 0, self.carouselView.bounds.size.width - 5, self.carouselView.bounds.size.height - 5);
    tagView.bounds = CGRectMake(0, 0, self.carouselView.bounds.size.width - 5, self.carouselView.bounds.size.height - 5);
    focusView.bounds = CGRectMake(0, 0, self.carouselView.bounds.size.width - 5, self.carouselView.bounds.size.height - 5);
    facilitiesView.bounds = CGRectMake(0, 0, self.carouselView.bounds.size.width - 5, self.carouselView.bounds.size.height - 5);
    
    self.items = [[NSMutableArray alloc] initWithObjects:contactView,geoView,tagView,focusView,facilitiesView, nil];
    
    
    self.carouselView.delegate = self;
    self.carouselView.dataSource = self;
    self.carouselView.type = iCarouselTypeInvertedCylinder;
}
-(void)createViewsWithInfo{

    _companyName.text = companyInfoObject.companyName;
    _companyInfoTextView.text = companyInfoObject.companyBio;
    _streetLabel.text = companyInfoObject.street;
    _cityLabel.text = companyInfoObject.city;
    _stateLabel.text = companyInfoObject.state;
    _zipLabel.text = companyInfoObject.zip;
    [self createCarousel];
    [self.carouselView reloadData];
}
#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    NSLog(@"%ld",(long)[self.items count]);
    return (NSInteger)[self.items count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
        
        switch (index) {
            case 0:
                view = [self.items objectAtIndex:index];
                break;
            case 1:
                view = [self.items objectAtIndex:index];
                break;
            case 2:
                view = [self.items objectAtIndex:index];
                break;
            case 3:
                view = [self.items objectAtIndex:index];
                break;
            case 4:
                view = [self.items objectAtIndex:index];
                break;
                
            default:
                break;
        }
    view.clipsToBounds = YES;
    view.contentMode = UIViewContentModeScaleToFill;
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return (NSInteger)[self.items count];;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    switch (index) {
        case 0:
            view = [self.items objectAtIndex:index];
            break;
        case 1:
            view = [self.items objectAtIndex:index];
            break;
        case 2:
            view = [self.items objectAtIndex:index];
            break;
        case 3:
            view = [self.items objectAtIndex:index];
            break;
        case 4:
            view = [self.items objectAtIndex:index];
            break;
            
        default:
            break;
    }
    view.clipsToBounds = YES;
    view.contentMode = UIViewContentModeScaleToFill;
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carouselView.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carouselView.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}
-(void)websiteBtnAction:(id)sender{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",companyInfoObject.companyWebsite]];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}
-(void)callingBtnAction:(id)sender{
    NSString *phNo = companyInfoObject.phone;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        //
    }
}
- (void)emailBtnAction:(id)sender {
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",companyInfoObject.contactEmail], nil]];
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
