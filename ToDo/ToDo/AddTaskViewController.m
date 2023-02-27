//
//  AddTaskViewController.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "AddTaskViewController.h"
#import "toDoViewController.h"
#import "Tasks.h"


@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
{
    Tasks *task ;
    NSUserDefaults *defToDo;
    NSData *archivedArr;
    
}
static NSMutableArray *tasksArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    task = [Tasks new];
   /* defToDo = [NSUserDefaults standardUserDefaults];
    
    
    archivedArr =[NSMutableData new];
    */
    /*
    
    */
    //getting Array from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archivedArr = [defToDo objectForKey:@"tasksArrr"];
    tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];
   
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    //getting Array from NS defualt
    /*archivedArr = [defToDo objectForKey:@"tasksArrr"];
    tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];*/
}
- (IBAction)addTaskButton:(id)sender {
    toDoViewController *toDoViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"toDoViewController"];
    
    
    [task setTaskTitle:_titleTextField.text];
    NSNumber *num = [[NSNumber alloc]initWithInteger:_priortySegment.selectedSegmentIndex];
    [task setTaskPeriority:num];
    [task setTaskCreationDate:_creationDate.date];
    
    [task setTaskDiscription:_discrptionTextView.text];
    
    
    //adding Array to NSDefualt
    
    //tasksArr = [NSMutableArray new];
    [tasksArr addObject:task];
    archivedArr = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
    [defToDo setObject:archivedArr forKey:@"tasksArrr"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
