//
//  CategoryJsonObject.h
//  GoLogo
//
//  Created by CSM on 3/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryJsonObject : NSObject

/*
 "id": "8",
 "companyId": "0",
 "categoryName": "Demo 3",
 "icon": "8.jpg",
 "description": "Demo",
 "parent": "1",
 "createDate": "2017-04-11 17:19:25",
 "categoryCreateBy": "0",
 "lastModifiedDate": "0000-00-00 00:00:00",
 "ModifiedBy": "0",
 "deleted": "0"
 
 */

@property (strong, nonatomic) NSString* categoryId;
@property (strong, nonatomic) NSString* companyId;
@property (strong, nonatomic) NSString* categoryName;
@property (strong, nonatomic) NSString* categoryDescription;
@property (strong, nonatomic) NSString* icon;
@property (strong, nonatomic) NSString* parent;
@end
