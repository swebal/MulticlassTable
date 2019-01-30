//
//  SwitchTableViewCell.m
//  MulticlassTable
//
//  Created by Markus on 2019-01-30.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

- (IBAction)switchValueChanged:(UISwitch *)sender {
    NSLog(@"Rad: %ld", self.tag);
    [_switchDelegate switchChangedForRow:self.tag];
}

- (void)configureForHorse:(Horse *)horse {
    self.nameLabel.text = horse.horseName;
    self.statusSwitch.on = horse.horseStatus;
}

@end
