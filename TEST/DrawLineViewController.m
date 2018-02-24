//
//  DrawLineViewController.m
//  TEST
//
//  Created by chenyun on 2017/10/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DrawLineViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface DrawLineViewController ()<MAMapViewDelegate, AMapNaviDriveManagerDelegate, AMapSearchDelegate, AMapLocationManagerDelegate> {
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) AMapDrivingRouteSearchRequest *driveRequest;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSArray *pathPolylines;

@end

@implementation DrawLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.mapType = MAMapTypeBus;
    self.mapView.delegate = self;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapDistrictSearchRequest *dis = [[AMapDistrictSearchRequest alloc] init];
    dis.keywords = @"上海市";
    dis.requireExtension = YES;
    [self.search AMapDistrictSearch:dis];
    
    self.driveRequest = [[AMapDrivingRouteSearchRequest alloc] init];
    self.driveRequest.requireExtension = YES;
    self.driveRequest.strategy = 5;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.delegate = self;
    self.locationManager.locatingWithReGeocode = YES;
    [self.locationManager startUpdatingLocation];

    
    [self test];
    
//    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:32.1607 longitude:118.6968];
//    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:32.3899 longitude:119.3507];
//
//    AMapGeoPoint *startPoint2 = [AMapGeoPoint locationWithLatitude:32.1607 longitude:118.6968];
//    AMapGeoPoint *endPoint2 = [AMapGeoPoint locationWithLatitude:32.3001 longitude:119.6907];
//
//    self.driveRequest.origin = startPoint;
//    self.driveRequest.destination = endPoint;
//
//    [self.search AMapDrivingRouteSearch:self.driveRequest];
    
}

- (void)test {
    
    for (NSInteger i = 0; i < 2; i++) {
        if (i == 0) {
            AMapDrivingRouteSearchRequest *drive1 = [[AMapDrivingRouteSearchRequest alloc] init];
            drive1.strategy = 5;
            AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:32.1607 longitude:118.6968];
            AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:32.3899 longitude:119.3507];
            drive1.origin = startPoint;
            drive1.destination = endPoint;
            
            [self.search AMapDrivingRouteSearch:drive1];
        }
        if (i == 1) {
            AMapDrivingRouteSearchRequest *drive2 = [[AMapDrivingRouteSearchRequest alloc] init];
            drive2.strategy = 5;
            AMapGeoPoint *startPoint2 = [AMapGeoPoint locationWithLatitude:32.2607 longitude:118.9968];
            AMapGeoPoint *endPoint2 = [AMapGeoPoint locationWithLatitude:31.22 longitude:121.48];
            drive2.origin = startPoint2;
            drive2.destination = endPoint2;
            
            [self.search AMapDrivingRouteSearch:drive2];
        }
    }
    
//    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:32.1607 longitude:118.6968];
//    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:32.3899 longitude:119.3507];
//
//    AMapGeoPoint *startPoint2 = [AMapGeoPoint locationWithLatitude:32.1607 longitude:118.6968];
//    AMapGeoPoint *endPoint2 = [AMapGeoPoint locationWithLatitude:32.3001 longitude:119.6907];
//
//    self.driveRequest.origin = startPoint;
//    self.driveRequest.destination = endPoint;
//
//    [self.search AMapDrivingRouteSearch:self.driveRequest];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route == nil)
    {
        return;
    }
//    NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route];
    
    AMapPath *path = response.route.paths[0]; //选择一条路径
    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    NSLog(@"%@",step.polyline);   //此路段坐标点字符串
    
    if (response.count > 0)
    {
        //移除地图原本的遮盖
//        [self.mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;

        // 只显⽰示第⼀条 规划的路径
        self.pathPolylines = [self polylinesForPath:response.route.paths[0]];
        NSLog(@"%@",response.route.paths[0]);
        //添加新的遮盖，然后会触发代理方法进行绘制
        [_mapView addOverlays:self.pathPolylines];
        [_mapView showOverlays:self.pathPolylines animated:YES];
    }
}

//路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        
        //          MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:count];
        
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    
    return coordinates;
}

//绘制遮盖时执行的代理方法
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    
    //画路线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth    = 2.f;
        polygonView.strokeColor  = [UIColor yellowColor];
        polygonView.lineJoinType = kMALineJoinRound;
        polygonView.lineCapType  = kMALineCapRound;
        //返回view，就进行了添加
        return polygonView;
    }
    return nil;
    
}  

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    NSLog(@"ddd");
}

- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response {
    NSLog(@"ee");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
