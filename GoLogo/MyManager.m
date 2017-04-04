//
//  MyManager.m
//  GoLogo
//
//  Created by CSM on 4/4/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager

@synthesize companyInfoArray;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MyManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        companyInfoArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
