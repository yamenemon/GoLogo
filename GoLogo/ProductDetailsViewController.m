//
//  ProductDetailsViewController.m
//  GoLogo
//
//  Created by CSM on 3/31/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController (){

    float productNameTextHeight;
    float productInfoTextHeight;
}
@end

@implementation ProductDetailsViewController
@synthesize productInfoScrollView;
@synthesize productJsonObject;
@synthesize productDetailImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (CGSize)getLabelHeight:(NSString*)text withFontSize:(UIFont*)font
{
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [text boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:font}
                                                  context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size;
}
-(void)viewDidLayoutSubviews{
    if (productJsonObject) {
        NSString *productName = (NSString*)productJsonObject.productName;
        NSString *productInfoDetail = (NSString*)productJsonObject.productDescription;
        productNameTextHeight = [self getLabelHeight:productName withFontSize:[UIFont systemFontOfSize:15.0f]].height;
        productInfoTextHeight = [self getLabelHeight:productInfoDetail withFontSize:[UIFont systemFontOfSize:15.0f]].height;
    }
    [self setUpProductImage];
    [self setUpScrollView];
    [self.view setNeedsDisplay];

}
-(void)setUpProductImage{
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",@"http://amadersolution.com/APItest/upload/product",productJsonObject.photo];
    [productDetailImageView sd_setImageWithURL:[NSURL URLWithString:baseUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}
-(void)setUpScrollView{
    NSArray *viewsToRemove = [productInfoScrollView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    float scrollerContentSize = 0;
    UILabel *productName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, productInfoScrollView.frame.size.width-20, productNameTextHeight)];
    productName.text = (NSString*)productJsonObject.productName;
    productName.textColor = [UIColor darkGrayColor];
    productName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    productName.numberOfLines = 0;
    productName.clipsToBounds = YES;
    [productName sizeToFit];
    productName.backgroundColor = [UIColor clearColor];
    [productInfoScrollView addSubview:productName];
    
    scrollerContentSize = 10+productName.frame.size.height;
    
    UILabel *productInfoDetail = [[UILabel alloc] initWithFrame:CGRectMake(10,10+scrollerContentSize, productInfoScrollView.frame.size.width-15, productInfoTextHeight)];
    productInfoDetail.text = (NSString*)productJsonObject.productDescription;
    productInfoDetail.font = [UIFont fontWithName:@"Helvetica-Light" size:13.0f];

    [productInfoDetail setLineBreakMode:NSLineBreakByWordWrapping];
    productInfoDetail.numberOfLines = 0;
    productInfoDetail.clipsToBounds = YES;
    [productInfoDetail sizeToFit];
    productInfoDetail.textColor = [UIColor lightGrayColor];
    productInfoDetail.backgroundColor = [UIColor clearColor];
    [productInfoScrollView addSubview:productInfoDetail];
    
    scrollerContentSize = 2*scrollerContentSize + 10 + productInfoDetail.frame.size.height;
    UIFont *fontName = [UIFont fontWithName:@"Helvetica-Light" size:15.0f];
    UILabel *salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10+scrollerContentSize,[self getLabelHeight:@"Sales Price" withFontSize:fontName].width, 30)];
    salesLabel.font = fontName;
    salesLabel.text = [NSString stringWithFormat:@"Sales Price"];
    salesLabel.textColor = [UIColor lightGrayColor];
    salesLabel.backgroundColor = [UIColor clearColor];
    [productInfoScrollView addSubview:salesLabel];
    
    float salesPriceLabelWidth = [self getLabelHeight:[NSString stringWithFormat:@"%@",(NSString*)productJsonObject.salePrice] withFontSize:fontName].width;
    UILabel *salesPrice = [[UILabel alloc] initWithFrame:CGRectMake(productInfoScrollView.frame.size.width-(salesPriceLabelWidth+20),10+scrollerContentSize,  [self getLabelHeight:[NSString stringWithFormat:@"%@",(NSString*)productJsonObject.salePrice] withFontSize:fontName].width, 30)];
    salesPrice.text = [NSString stringWithFormat:@"%@",(NSString*)productJsonObject.salePrice];
    salesPrice.textColor = [UIColor lightGrayColor];
    salesPrice.font = fontName;
    salesPrice.backgroundColor = [UIColor clearColor];
    [productInfoScrollView addSubview:salesPrice];
    salesPrice.textAlignment = NSTextAlignmentRight;
    scrollerContentSize = scrollerContentSize + 10 + 30;
    
    float retailPriceLabelWidth = [self getLabelHeight:[NSString stringWithFormat:@"%@",(NSString*)productJsonObject.retailPrice] withFontSize:fontName].width;

    UILabel *retailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10+scrollerContentSize,[self getLabelHeight:@"Retail Price" withFontSize:fontName].width, 30)];
    retailLabel.font = fontName;
    retailLabel.text = [NSString stringWithFormat:@"Retail Price"];
    retailLabel.textColor = [UIColor lightGrayColor];
    retailLabel.backgroundColor = [UIColor clearColor];
    [productInfoScrollView addSubview:retailLabel];
    
    UILabel *retailPrice = [[UILabel alloc] initWithFrame:CGRectMake(productInfoScrollView.frame.size.width-(retailPriceLabelWidth+20),10+scrollerContentSize, [self getLabelHeight:[NSString stringWithFormat:@"%@",(NSString*)productJsonObject.retailPrice] withFontSize:fontName].width, 30)];
    retailPrice.font = fontName;
    retailPrice.text = [NSString stringWithFormat:@"%@",(NSString*)productJsonObject.retailPrice];
    retailPrice.textColor = [UIColor lightGrayColor];
    retailPrice.backgroundColor = [UIColor clearColor];
    retailPrice.textAlignment = NSTextAlignmentRight;
    [productInfoScrollView addSubview:retailPrice];
    
    productInfoScrollView.contentSize = CGSizeMake(productInfoScrollView.frame.size.width, scrollerContentSize);
    [self.view setNeedsDisplay];

}
- (IBAction)buttonSelectionState:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.selected == NO) {
        btn.selected = YES;
    }
    else{
        btn.selected = NO;
    }
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
