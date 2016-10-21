//
//  RestaurantsFetched.h
//  swiggyApp
//
//  Created by deepakraj murugesan on 20/10/16.
//  Copyright © 2016 deepakraj murugesan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantsFetched : UITableViewCell
@property(nonatomic,weak)NSDictionary * restaurantDict;
@property (weak, nonatomic) IBOutlet UIButton *btnExpand;

@end
