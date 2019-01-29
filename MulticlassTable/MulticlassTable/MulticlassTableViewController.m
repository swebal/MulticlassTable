//
//  MulticlassTableViewController.m
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "MulticlassTableViewController.h"
#import "BrownTableViewCell.h"
#import "Horse.h"

@interface MulticlassTableViewController ()

@property (nonatomic, strong) NSMutableArray *horses;

@end

@implementation MulticlassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.horses = [NSMutableArray new];
    for (int i=0; i<1000; i++) {
        Horse *h = [Horse randomHorse];
        [_horses addObject:h];
    }
    
    // Man kan bara spara följande typer i NSUserDefaults:
    // NSNumber, NSArray, NSString, NSData, NSDictionary, NSDate
    // Vi vill spara en array med häst-dictionaries!
    
    NSMutableArray *horseDictionaries = [NSMutableArray new];
    for (Horse *h in _horses) {
        NSDictionary *horseData = [h dictionaryFromObject];
        [horseDictionaries addObject:horseData];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:horseDictionaries forKey:@"horseDataArray"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _horses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BrownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Horse *h = _horses[indexPath.row];
    [cell configureWithHorse:h];
    
    return cell;
}

@end
