//
//  DetailViewController.h
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Horse.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Horse *selectedHorse;
@property (weak, nonatomic) IBOutlet UILabel *horseNameLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;

@end
