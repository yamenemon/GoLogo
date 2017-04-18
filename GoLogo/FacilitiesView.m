//
//  FacilitiesView.m
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "FacilitiesView.h"

@implementation FacilitiesView

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
-(void)loadFacilities{
    
    //NSArray *strings = [_companyInfoObject.focusProdcut componentsSeparatedByString:@";"];
    NSString *string = [NSString stringWithFormat:@"%@",_companyInfoObject.facilities];
    _facilitiesLabel.text = string;//[strings objectAtIndex:0];
    _facilitiesLabel.numberOfLines = 0;
    [_facilitiesLabel sizeToFit];
    _facilitiesLabel.clipsToBounds = YES;
}
@end
