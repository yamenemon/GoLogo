//
//  ProductJsonObject.h
//  GoLogo
//
//  Created by CSM on 3/28/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductJsonObject : NSObject
@property (strong, nonatomic) NSString* categoryld;
@property (strong, nonatomic) NSString* productName;
@property (strong, nonatomic) NSString* productDescription;
@property (strong, nonatomic) NSString* photo;
@property (strong, nonatomic) NSString* socialLink;
@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* retailPrice;
@property (strong, nonatomic) NSString* salePrice;

@end
