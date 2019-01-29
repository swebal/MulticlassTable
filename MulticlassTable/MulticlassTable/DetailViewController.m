//
//  DetailViewController.m
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.horseNameLabel.text = self.selectedHorse.horseName;
    self.statusView.backgroundColor = _selectedHorse.horseStatus == HorseStatusAlive ? [UIColor greenColor] : [UIColor redColor];
}

@end
