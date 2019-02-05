//
//  SwitchTableViewCellDelegate.h
//  MulticlassTable
//
//  Created by Markus on 2019-02-05.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

@protocol SwitchTableViewCellDelegate <NSObject>

- (void)switchChangedForRow:(NSInteger)rowIndex;

@end
