//
//  toDoViewController.h
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface toDoViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySegments;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property Tasks *taskContainer;
@property  NSInteger *sellctedObjectIndex;
@property NSInteger *toDoIndexItem;
@end

NS_ASSUME_NONNULL_END
