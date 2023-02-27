//
//  AddTaskViewController.h
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySegment;

@property (weak, nonatomic) IBOutlet UITextView *discrptionTextView;
@property Tasks *taskContainer;

@property (weak, nonatomic) IBOutlet UIDatePicker *creationDate;


@end

NS_ASSUME_NONNULL_END
