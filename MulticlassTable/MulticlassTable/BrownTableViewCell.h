//
//  BrownTableViewCell.h
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Horse.h"

@interface BrownTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameOfHorse;
@property (weak, nonatomic) IBOutlet UIView *statusView;

- (void)configureWithHorse:(Horse *)horse;

@end
