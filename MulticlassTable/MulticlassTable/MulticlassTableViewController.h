//
//  MulticlassTableViewController.h
//  MulticlassTable
//
//  Created by Markus on 2019-01-29.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MulticlassTableViewController : UITableViewController 

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

- (IBAction)searchTextChanged:(UITextField *)sender; // När texten i textfältet ändras
- (IBAction)returnPressed:(id)sender; // När man trycker på retur-knappen på tangentbordet

@end
