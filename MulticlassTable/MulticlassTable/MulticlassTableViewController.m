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
#import "DetailViewController.h"
#import "SwitchTableViewCell.h"

@interface MulticlassTableViewController () <SwitchTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *horses;

@end

@implementation MulticlassTableViewController

- (void)switchChangedForRow:(NSInteger)rowIndex {
    NSLog(@"En rad tryckte på: %ld", rowIndex);
    Horse *h = _horses[rowIndex];
    if (h.horseStatus == HorseStatusAlive) {
        h.horseStatus = HorseStatusDead;
    } else {
        h.horseStatus = HorseStatusAlive;
    }
    [self saveHorses];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self loadHorses]) {
        [self saveHorses];
    }
}

- (void)saveHorses {
    
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

- (BOOL)loadHorses {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedHorses = [defaults arrayForKey:@"horseDataArray"];
    self.horses = [NSMutableArray new];
    if (savedHorses) {
        for (NSDictionary *horseData in savedHorses) {
            Horse *h = [[Horse alloc] initWithDictionary:horseData]; // nåt med att parsa data...
            [_horses addObject:h];
        }
        return false;
    } else {
        for (int i=0; i<100; i++) {
            Horse *h = [Horse randomHorse];
            [_horses addObject:h];
        }
        return true;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _horses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Horse *h = _horses[indexPath.row];
    
    if (indexPath.row % 2 == 0) { // Jämna rader
        BrownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        [cell configureWithHorse:h];
        return cell;
    } else { // Ojämna rader
        
        
        SwitchTableViewCell *sw = [tableView dequeueReusableCellWithIdentifier:@"switch" forIndexPath:indexPath];
        [sw configureForHorse:h];
        sw.switchDelegate = self;
        // CELL.
        // OBJECT.PROPERTY = OBJECT;
        sw.tag = indexPath.row;
        return sw;
        
        
    }
}

#pragma mark - Prepare for transition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detail = (DetailViewController *)segue.destinationViewController;
        Horse *selectedHorse = (Horse *)[_horses objectAtIndex:selectedIndexPath.row]; // Samma som: _horses[selectedIndexPath.row];
        detail.selectedHorse = selectedHorse;
    }
}

@end
