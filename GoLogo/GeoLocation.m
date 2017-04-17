//
//  GeoLocation.m
//  GoLogo
//
//  Created by CSM on 4/12/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "GeoLocation.h"
#import <CoreLocation/CoreLocation.h>
@implementation GeoLocation 
@synthesize latitude;
@synthesize longitude;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)loadMap{
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=latitude;
    myCoordinate.longitude=longitude;
    annotation.coordinate = myCoordinate;
    annotation.title = @"GoLogo";
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = self;
    [self.mapView addAnnotation:annotation];
}
- (void)setAnnotation:(id <MKAnnotation>)annotation
{
}
- (MKAnnotationView *)mapView:(MKMapView *)m
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"RootViewController mapView: viewForAnnotation:");
    NSLog(@"%f",annotation.coordinate.latitude);
    [self setNeedsDisplay];

    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.enabled = YES;
    pin.canShowCallout = YES;
    
    return pin;
}
@end
