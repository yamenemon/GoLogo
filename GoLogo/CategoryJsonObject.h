//
//  CategoryJsonObject.h
//  GoLogo
//
//  Created by CSM on 3/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryJsonObject : NSObject

//"id":"2",
//"companyId":"1",
//"categoryName":"cap",
//"icon":"cap.jpg",
//"description":"this is about shirt",
//"createDate":"2017-03-21 22:28:38",
//"modifyDate":"0000-00-00 00:00:00"


@property (strong, nonatomic) NSString* companyId;
@property (strong, nonatomic) NSString* categoryName;
@property (strong, nonatomic) NSString* categoryDescription;
@property (strong, nonatomic) NSString* icon;

@end
