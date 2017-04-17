//
//  TaglineView.m
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "TaglineView.h"

@implementation TaglineView

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
-(void)loadTaglines{

    NSArray *strings = [_companyInfoObject.tagLine componentsSeparatedByString:@";"];
    _tagHeaderLabel.text = [strings objectAtIndex:0];
    NSString *des = [_companyInfoObject.tagLine stringByReplacingOccurrencesOfString:[strings objectAtIndex:0] withString:@""];
    NSString *newString = [des stringByReplacingOccurrencesOfString:@";" withString:@"\r=>"];
    _tagDescriptionTextView.text = newString;

}
@end
