//
//  ViewController.h
//  PlaceAPITest
//
//  Created by 윤치호 on 2016. 6. 23..
//  Copyright © 2016년 윤치호. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
@import GoogleMaps;

@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UILabel *lblLongitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLatitude;
@property (weak, nonatomic) IBOutlet UILabel *lblAltitude;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaces;

@property GMSPlacesClient *placesClient;
@end