//
//  ViewController.m
//  TEST
//
//  Created by chenyun on 2017/9/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController () <MAMapViewDelegate, AMapNaviDriveManagerDelegate, AMapSearchDelegate> {
    
    NSInteger count;
}

// 导航sdk
@property (nonatomic, strong) AMapNaviPoint *startPoint;

@property (nonatomic, strong) AMapNaviPoint *endPoint;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapNaviDriveManager *driverManager;

@property (nonatomic, strong) MAPolyline *commonPolyline;
@property (nonatomic, strong) MAPolyline *commonPolyline2;

//搜索sdk

//@property (nonatomic, strong) AMapSearchAPI *searchAPI;
//
//@property (nonatomic, strong) AMapGeocodeSearchRequest *startGeo;
//
//@property (nonatomic, strong) AMapGeocodeSearchRequest *endGeo;
//
//@property (nonatomic, strong) AMapGeoPoint *startPoint;
//
//@property (nonatomic, strong) AMapGeoPoint *endPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startPoint = [AMapNaviPoint locationWithLatitude:32.1607 longitude:118.6968];
    self.endPoint = [AMapNaviPoint locationWithLatitude:32.3899 longitude:119.3507];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.mapType = MAMapTypeStandardNight;
    [self.view addSubview:self.mapView];
    
    self.driverManager = [[AMapNaviDriveManager alloc] init];
    self.driverManager.delegate = self;
    
    [self.driverManager calculateDriveRouteWithStartPoints:@[self.startPoint] endPoints:@[self.endPoint] wayPoints:nil drivingStrategy:2];
    
    AMapNaviPoint *endPoint2 = [AMapNaviPoint locationWithLatitude:32.3899 longitude:119.3698];
    [self.driverManager calculateDriveRouteWithStartPoints:@[self.startPoint] endPoints:@[endPoint2] wayPoints:nil drivingStrategy:2];
//    self.searchAPI = [[AMapSearchAPI alloc] init];
//    self.searchAPI.delegate = self;
//
//    self.startGeo = [[AMapGeocodeSearchRequest alloc] init];
//    self.startGeo.address = @"南京";
//    self.endGeo = [[AMapGeocodeSearchRequest alloc] init];
//    self.endGeo.address = @"扬州";
//
//    [self.searchAPI AMapGeocodeSearch:self.startGeo];
//    [self.searchAPI AMapGeocodeSearch:self.endGeo];
    
    
//    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    mapView.mapType = MAMapTypeStandardNight;
//    mapView.delegate = self;
//    [self.view addSubview:mapView];
//    CLLocationCoordinate2D commonPolylineCoords[4];
//    commonPolylineCoords[0].latitude = 39.83;
//    commonPolylineCoords[0].longitude = 116.34;
//
//    commonPolylineCoords[1].latitude = 39.83;
//    commonPolylineCoords[1].longitude = 116.42;
//
//    commonPolylineCoords[2].latitude = 39.90;
//    commonPolylineCoords[2].longitude = 116.42;
//
//    commonPolylineCoords[3].latitude = 39.90;
//    commonPolylineCoords[3].longitude = 116.44;
//
//    //构造折线对象
//    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
//    [mapView addOverlay:commonPolyline];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 5.f;
        polylineRenderer.strokeColor  = [UIColor yellowColor];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}


- (void)searchDrive {
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    navi.strategy = 2;
//    navi.origin = self.startPoint;
//    navi.destination = self.endPoint;
//    [self.searchAPI AMapDrivingRouteSearch:navi];
}

#pragma mark - AMapNaviDriveManagerDelegate

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    AMapNaviRoute *route = driveManager.naviRoute;
    NSArray<AMapNaviPoint *> *routeCoordinates = route.routeCoordinates;
    [self test:routeCoordinates];
    NSLog(@"%ld", (long)route.routeLength);
}



- (void)test:(NSArray<AMapNaviPoint *> *)test {
//    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    mapView.mapType = MAMapTypeStandardNight;
//    mapView.delegate = self;
//    mapView.showsUserLocation = YES;
//    mapView.userTrackingMode = MAUserTrackingModeFollow;
//    [self.view addSubview:mapView];
    
    if (count == 1) {
        CLLocationCoordinate2D commonPolylineCoords[test.count];
        for (NSInteger i = 0; i < test.count; i++) {
            commonPolylineCoords[i].latitude = test[i].latitude;
            commonPolylineCoords[i].longitude = test[i].longitude;
        }
//        if (self.commonPolyline) {
//            [self.mapView removeOverlay:self.commonPolyline];
//        }
        
        //构造折线对象
        self.commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:test.count];
        if (self.commonPolyline != nil) {
            [self.mapView addOverlay:self.commonPolyline];
        }
    } else {
        CLLocationCoordinate2D commonPolylineCoords[test.count];
        for (NSInteger i = 0; i < test.count; i++) {
            commonPolylineCoords[i].latitude = test[i].latitude;
            commonPolylineCoords[i].longitude = test[i].longitude;
        }
        if (self.commonPolyline) {
            [self.mapView removeOverlay:self.commonPolyline];
        }
        
        //构造折线对象
        self.commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:test.count];
        if (self.commonPolyline != nil) {
            [self.mapView addOverlay:self.commonPolyline];
        }
         [self.mapView showOverlays:self.mapView.overlays animated:YES];
        count++;
        AMapNaviPoint *point1 = [AMapNaviPoint locationWithLatitude:32.1607 longitude:118.6968];
        AMapNaviPoint *point2 = [AMapNaviPoint locationWithLatitude:32.1699 longitude:118.9968];
        AMapNaviPoint *point3 = [AMapNaviPoint locationWithLatitude:32.2607 longitude:119.1968];
        AMapNaviPoint *point4 = [AMapNaviPoint locationWithLatitude:32.3899 longitude:119.3507];
        NSArray<AMapNaviPoint *> *arr = @[point1, point2,point3,point4];
        [self test:arr];
    }
    
    
//    CLLocationCoordinate2D commonPolylineCoords[4];
//    commonPolylineCoords[0].latitude = 39.83;
//    commonPolylineCoords[0].longitude = 116.34;
//    
//    commonPolylineCoords[1].latitude = 39.83;
//    commonPolylineCoords[1].longitude = 116.42;
//    
//    commonPolylineCoords[2].latitude = 39.90;
//    commonPolylineCoords[2].longitude = 116.42;
//    
//    commonPolylineCoords[3].latitude = 39.90;
//    commonPolylineCoords[3].longitude = 116.44;
    
    
    [self.mapView showOverlays:self.mapView.overlays animated:YES];
}

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    NSArray <AMapGeocode*>*array = response.geocodes;
    if (array.count <= 0) {
        return;
    }
    
//    if (request == self.startGeo) {
//        self.startPoint = array[0].location;
//    }
//    if (request == self.endGeo) {
//        self.endPoint = array[0].location;
//    }
    
    if (self.startPoint && self.endPoint) {
        [self searchDrive];
    }
    
    NSLog(@"%@", array);
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route == nil) {
        return;
    }
    AMapRoute *route = response.route;
    
    if (route.paths.count <= 0) {
        return;
    }
    
    AMapPath *path = route.paths[0];
    NSLog(@"%ld", (long)path.distance);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
