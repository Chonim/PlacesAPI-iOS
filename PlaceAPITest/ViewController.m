//
//  ViewController.m
//  PlaceAPITest
//
//  Created by 윤치호 on 2016. 6. 23..
//  Copyright © 2016년 윤치호. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        // Or [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    self.placesClient = [GMSPlacesClient sharedClient];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    self.location = locations.lastObject;
    self.lblLatitude.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    self.lblLongitude.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    self.lblAltitude.text = [NSString stringWithFormat:@"%f", self.location.altitude];
    
    NSLog(@"%@", self.location.description);
    
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        NSMutableString *strPlaces = [NSMutableString stringWithString:@""];
        
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods)
        {
            GMSPlace* place = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", place.formattedAddress);
            NSLog(@"Current Place attributions %@", place.attributions);
            NSLog(@"Current PlaceID %@", place.placeID);
            [strPlaces appendString:place.name];
            [strPlaces appendString:@" "];
            [strPlaces appendFormat:@"%g",likelihood.likelihood];
            [strPlaces appendString:@"\n"];
        }
        self.lblPlaces.text = strPlaces;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
