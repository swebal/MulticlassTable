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
#import "SwitchTableViewCellDelegate.h"

#define kHorseArrayDataKey          @"data005"
#define kNumberOfHorses             50

@interface MulticlassTableViewController () <SwitchTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *horses;
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, assign) BOOL sortAscending; // Falsk default
@end

@implementation MulticlassTableViewController

- (void)switchChangedForRow:(NSInteger)rowIndex {
    NSLog(@"En rad tryckte på: %ld", rowIndex);
    Horse *h = nil;
    
    if (_searchResult.count > 0) {
        h = _searchResult[rowIndex];
    } else {
        h = _horses[rowIndex];
    }
    
    if (h.horseStatus == HorseStatusAlive) {
        h.horseStatus = HorseStatusDead;
    } else {
        h.horseStatus = HorseStatusAlive;
    }
    [self saveHorses];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResult = [NSMutableArray new];
    if ([self loadHorses]) {
        [self saveHorses];
    }
    [self filterWithString:nil];
    
    // Skapar en knapp för vår navigation item!
    
    UIBarButtonItem *knapp = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:(UIBarButtonItemStylePlain) target:self action:@selector(sortHorses)];
    self.navigationItem.rightBarButtonItem = knapp;
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
    [defaults setObject:horseDictionaries forKey:kHorseArrayDataKey];
}

- (BOOL)loadHorses {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedHorses = [defaults arrayForKey:kHorseArrayDataKey];
    self.horses = [NSMutableArray new];
    if (savedHorses) {
        for (NSDictionary *horseData in savedHorses) {
            Horse *h = [[Horse alloc] initWithDictionary:horseData];
            [_horses addObject:h];
        }
        return false;
    } else {
        for (int i=0; i<kNumberOfHorses; i++) {
            Horse *h = [Horse randomHorse];
            [_horses addObject:h];
        }
        return true;
    }
}

- (void)sortHorses {
    _sortAscending = !_sortAscending;
    [_searchResult sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Horse *h1 = (Horse *)obj1;
        Horse *h2 = (Horse *)obj2;
        if (self.sortAscending) {
            return [h1.horseName compare:h2.horseName];
        }
        return [h2.horseName compare:h1.horseName];
    }];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    
    // Nedanstående skall ändras beroender på sökresultat
    
    BOOL allHorses = _searchResult.count == _horses.count;
    label.text = allHorses ? @"All horsies" : [NSString stringWithFormat:@"Search result for \"%@\": %ld", _searchString, _searchResult.count];
    
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 3;
//    }
    return _searchResult.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Horse *h = _searchResult[indexPath.row];
    
//    if (indexPath.row % 2 == 0) { // 0%3=0, 1%3=1, 2%3=2, 3%3=0, 4%3=1, 5%3=2, 6%3=0
//        BrownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//        [cell configureWithHorse:h];
//        return cell;
//    }
//    else { // Ojämna rader
    
        
        SwitchTableViewCell *sw = [tableView dequeueReusableCellWithIdentifier:@"switch" forIndexPath:indexPath];
        [sw configureForHorse:h];
        sw.switchDelegate = self;
        // OBJECT.PROPERTY = OBJECT; (raden ovan)
        sw.tag = indexPath.row;
        return sw;
        
        
//    }
}

- (void)cellIsHungry {
    NSLog(@"Cell is hungry!");
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

#pragma mark - Search

- (void)filterWithString:(NSString *)string {
    self.searchString = string;
    [_searchResult removeAllObjects];
    if (string.length > 0) {
        for (Horse *h in _horses) {
            if ([h.horseName.lowercaseString containsString:string.lowercaseString]) {
                [_searchResult addObject:h];
            }
        }
    } else {
        [self.searchResult addObjectsFromArray:_horses];
    }
    [self.tableView reloadData];
}

- (IBAction)searchTextChanged:(UITextField *)sender {
    [self filterWithString:sender.text];
}

- (IBAction)returnPressed:(id)sender {
    [_searchTextField resignFirstResponder];
}

@end
