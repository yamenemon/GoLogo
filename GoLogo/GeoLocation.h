//
//  GeoLocation.h
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GeoLocation : UIView <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
-(void)loadMap;
@end
