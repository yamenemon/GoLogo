//
//  ContactView.m
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "ContactView.h"
#import "CompanyViewController.h"

@implementation ContactView
@synthesize companyInfoObject;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    [self shakeView];
    [self shakeEmail];
    [self shakeWebsite];
}
-(void)shakeWebsite{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.2];
    [shake setRepeatCount:5.0];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(_websiteImage.center.x,_websiteImage.center.y+5)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(_websiteImage.center.x, _websiteImage.center.y-5)]];
    [_websiteImage.layer addAnimation:shake forKey:@"position"];
}

-(void)shakeView {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.2];
    [shake setRepeatCount:5.0];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(_callingImage.center.x ,_callingImage.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(_callingImage.center.x + 5, _callingImage.center.y)]];
    [_callingImage.layer addAnimation:shake forKey:@"position"];
}
-(void)shakeEmail{
    
    CABasicAnimation *shakeEmail = [CABasicAnimation animationWithKeyPath:@"position"];
    [shakeEmail setDuration:0.2];
    [shakeEmail setRepeatCount:5.0];
    [shakeEmail setAutoreverses:YES];
    [shakeEmail setFromValue:[NSValue valueWithCGPoint:
                              CGPointMake(_emailImage.center.x + 5,_emailImage.center.y)]];
    [shakeEmail setToValue:[NSValue valueWithCGPoint:
                            CGPointMake(_emailImage.center.x - 5, _emailImage.center.y)]];
    [_emailImage.layer addAnimation:shakeEmail forKey:@"position"];
    
}
- (IBAction)callingBtnAction:(id)sender {
    [_baseController callingBtnAction:sender];
}
- (IBAction)websiteBtnAction:(id)sender {
    [_baseController websiteBtnAction:sender];
}
- (IBAction)mailBtnAction:(id)sender {
    [_baseController emailBtnAction:sender];
}

@end
