//
//  MyManager.h
//  GoLogo
//
//  Created by CSM on 4/4/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSMutableArray *companyInfoArray;

+ (id)sharedManager;

@end
