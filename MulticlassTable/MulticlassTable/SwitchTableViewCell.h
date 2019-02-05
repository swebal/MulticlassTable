//
//  SwitchTableViewCell.h
//  MulticlassTable
//
//  Created by Markus on 2019-01-30.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Horse.h"
#import "SwitchTableViewCellDelegate.h"

@interface SwitchTableViewCell : UITableViewCell

@property (assign) id<SwitchTableViewCellDelegate> switchDelegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;

- (IBAction)switchValueChanged:(UISwitch *)sender;

- (void)configureForHorse:(Horse *)horse;
//- (void)configureWithDictionary:(NSDictionary *)data;

@end
