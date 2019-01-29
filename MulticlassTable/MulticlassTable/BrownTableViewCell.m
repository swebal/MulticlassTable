//
//  BrownTableViewCell.m
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "BrownTableViewCell.h"

@implementation BrownTableViewCell

- (void)configureWithHorse:(Horse *)horse {
    self.nameOfHorse.text = horse.horseName;
    [self setViewColorWithHorseStatus:horse.horseStatus];
}

- (void)setViewColorWithHorseStatus:(HorseStatus)horseStatus {
    UIColor *statusColor = nil;
    switch (horseStatus) {
        case HorseStatusDead:
            statusColor = [UIColor redColor];
            break;
        case HorseStatusAlive:
            statusColor = [UIColor greenColor];
            break;
        default:
            break;
    }
    self.statusView.backgroundColor = statusColor;
}

@end
