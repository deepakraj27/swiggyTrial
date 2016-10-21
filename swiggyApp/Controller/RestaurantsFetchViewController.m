//
//  RestaurantsFetchViewController.m
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import "RestaurantsFetchViewController.h"
#import "WebServices.h"
#import "MBProgressHUD.h"
#import "RestaurantsFetched.h"
#import "SwiggyUtility.h"
#import "DefinesURL.h"
#import "Constants.h"

@interface RestaurantsFetchViewController ()<UITableViewDelegate, UITableViewDataSource, alertViewBtnHandle>{
    SwiggyUtility * alertUtility;
    NSArray * chainArr;
}
@property (strong, nonatomic) IBOutlet UITableView *restaurantsTableView;
@property(nonatomic, retain)NSMutableArray * restaurantsArray;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation RestaurantsFetchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantsArray = [[NSMutableArray alloc]init];
    alertUtility = [[SwiggyUtility alloc]init];
    alertUtility.delegate = self;
    [self restaurantAPIFetch];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate-Scrolling disabled
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.restaurantsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantsFetched * restaurants = [tableView dequeueReusableCellWithIdentifier:@"restaurants" forIndexPath:indexPath];
    restaurants.restaurantDict = self.restaurantsArray[indexPath.row];
    restaurants.selectionStyle = UITableViewCellSelectionStyleNone;
    return restaurants;
}

#pragma mark - API CALL
-(void)restaurantAPIFetch{
    if ([SwiggyUtility isConnectedTointernet]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WebServices sharedInstance]swiggyURL:RestaurantsURL HTTPmethod:GET_METHOD forParameters:@"" Authorization:@"" ContentType:JSON_Content onCompletion:^(NSDictionary *responseData, NSURLResponse *statusCode) {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) statusCode;
            NSString * responseStatusCode =[NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
            NSLog(@"response code of restaurants api fetch: %@", responseStatusCode);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (([responseData isKindOfClass:[NSDictionary class]] && [responseStatusCode isEqualToString:status_OK] && [responseData[@"restaurants"] count] > 0)) {
                self.restaurantsArray = responseData[@"restaurants"];
                NSLog(@"response of restaurants api fetch: %@",self.restaurantsArray);
                self.restaurantsTableView.hidden = NO;
                self.headerView.hidden = NO;
                [self.restaurantsTableView reloadData];
                self.restaurantsTableView.delegate = self;
                self.restaurantsTableView.dataSource = self;
            }
            else{
                UIAlertController * alert = [alertUtility dynamicAlert: @"" :something :[NSArray arrayWithObjects:@"OK", nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    else{
        UIAlertController * alert = [alertUtility dynamicAlert: NOInternetTitle :NOInternetMessage :[NSArray arrayWithObjects:@"Try Again", nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


-(void)alertbtn:(NSString *)btnHeading{
    if ([btnHeading isEqualToString:@"Try Again"]) {
        [self restaurantAPIFetch];
    }
}


@end
