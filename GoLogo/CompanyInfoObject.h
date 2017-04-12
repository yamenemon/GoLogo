//
//  CompanyInfoObject.h
//  GoLogo
//
//  Created by CSM on 4/4/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyInfoObject : NSObject
/*
 "id":"5",
 "companyName":"GoLogo",
 "street":"GoLogo Street",
 "city":"Demo City",
 "state":"AK",
 "zip":"1230",
 "phone":"8801841664",
 "contactName":"GoLogo",
 "contactEmail":"GoLogoo@GoLogo.com",
 "companyBio":"GoLogoGoLogoGoLogoGoLogo",
 "companyLogo":"5.png",
 "companyWebsite":"https:\/\/GoLogo.com\/",
 "note":"",
 "createDate":"2017-04-04 12:53:14",
 "lastModifiedDate":"0000-00-00 00:00:00"
 */
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *contactName;
@property (strong, nonatomic) NSString *contactEmail;
@property (strong, nonatomic) NSString *companyBio;
@property (strong, nonatomic) NSString *companyLogo;
@property (strong, nonatomic) NSString *companyWebsite;
@property (strong, nonatomic) NSString *facilities;
@property (strong, nonatomic) NSString *focusProdcut;
@property (strong, nonatomic) NSString *geoLocation;
@property (strong, nonatomic) NSString *tagLine;
@property (strong, nonatomic) NSString *note;

@end
