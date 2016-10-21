//
//  RestaurantsFetched.m
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import "RestaurantsFetched.h"
#import "UIImageView+WebCache.h"

@interface RestaurantsFetched()
@property (weak, nonatomic) IBOutlet UIImageView *restaurantMainImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTitle;
@property (weak, nonatomic) IBOutlet UILabel *restaurantType;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *avgRating;
@property (weak, nonatomic) IBOutlet UILabel *otherRestaurant;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantAvailablity;

@property (weak, nonatomic) IBOutlet UILabel *amountForTwo;
@end
@implementation RestaurantsFetched

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRestaurantDict:(NSDictionary *)restaurantDict{
self.amountForTwo.text = restaurantDict[@"costForTwo"];

    if ([restaurantDict[@"chain"] count] != 0) {
        self.otherRestaurant.hidden = NO;
        NSString* chainName ;
        NSMutableArray* nameList = [[NSMutableArray alloc]init];
        for (NSDictionary* dict in restaurantDict[@"chain"]) {
            chainName = dict[@"area"];
            [nameList addObject:chainName];
        }
        NSLog(@"name list: %@",nameList);
        
        NSString * stringToDisplay = [nameList componentsJoinedByString:@", "];
        self.otherRestaurant.text = [@"Chains at " stringByAppendingString:stringToDisplay];
    }
    else{
        self.otherRestaurant.hidden = YES;
    }
    self.restaurantMainImage.image = [UIImage imageNamed:@"Placeholder"];
    
    self.restaurantTitle.text = restaurantDict[@"name"];
    
    NSArray *listOfWords = restaurantDict[@"cuisine"];
    NSString * stringToDisplay = [listOfWords componentsJoinedByString:@", "];
    self.restaurantType.text = stringToDisplay;

    double time = [restaurantDict[@"deliveryTime"] doubleValue];
    NSString* timeValue = [NSString stringWithFormat:@"%.f Mins",time];
    self.deliveryTime.text = timeValue;
    
    self.avgRating.text = restaurantDict[@"avg_rating"];
    
    BOOL isClosed = [restaurantDict[@"closed"] boolValue];
    if (isClosed == YES) {
        self.restaurantAvailablity.image = [UIImage imageNamed:@"close"];
    }
    else{
        self.restaurantAvailablity.image = [UIImage imageNamed:@"open"];

    }
    
//    if ([restaurantDict[@"cid"] isKindOfClass:[NSNull class]] || restaurantDict[@"cid"] == nil ||  [restaurantDict[@"cid"] isEqualToString:@"null"])
//    {
//        self.restaurantMainImage.image = [UIImage imageNamed:@"default_panellist"];
//        
//    }
//    else
//    {
//        [self.restaurantMainImage sd_setImageWithURL:[NSURL URLWithString:restaurantDict[@"cid"]]
//                          placeholderImage:[UIImage imageNamed:@"default_panellist"]];
//        
//    }
    _restaurantDict = restaurantDict;
}
@end
