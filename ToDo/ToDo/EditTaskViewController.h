//
//  EditTaskViewController.h
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextViewEdit;
@property (weak, nonatomic) IBOutlet UITextView *discriptionTextFiewEdit;

@property (weak, nonatomic) IBOutlet UISegmentedControl *taskPriorityEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskStatEdit;
@property Tasks *viewDetailsOfSellectedCell;

@property NSInteger *indexNum;
@property NSString *arrayCommingFrom;


@end

NS_ASSUME_NONNULL_END
