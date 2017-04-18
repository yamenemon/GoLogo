//
//  FocusProductView.m
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "FocusProductView.h"

@implementation FocusProductView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    
}
-(void)loadFocusProducts{
    
    //NSArray *strings = [_companyInfoObject.focusProdcut componentsSeparatedByString:@";"];
    NSString *string = [NSString stringWithFormat:@"%@",_companyInfoObject.focusProdcut];
    _focusProductsLabel.text = string;//[strings objectAtIndex:0];
    _focusProductsLabel.numberOfLines = 0;
    [_focusProductsLabel sizeToFit];
    _focusProductsLabel.clipsToBounds = YES;
}
@end
