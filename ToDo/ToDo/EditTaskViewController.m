//
//  EditTaskViewController.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "EditTaskViewController.h"
#import "Tasks.h"
#import "toDoViewController.h"
#import "DoneViewController.h"
#import "InProgressViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController
{
    
    NSUserDefaults *defToDo;
    NSData *archivedArr;
    NSData *archivedInProgressArr;
    NSData *archivedDoneArr;
    NSData *p;
    NSData *l;
    
 
    NSData *archivedObject;
}
static NSMutableArray *tasksArry;
static NSMutableArray *inprogArry;
static NSMutableArray *doneArry;

+(void)initialize{
    tasksArry=[NSMutableArray new];
    inprogArry=[NSMutableArray new];
    doneArry=[NSMutableArray new];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    defToDo = [NSUserDefaults standardUserDefaults];
    
    //getting todoArray from NS defualt
   // defToDo = [NSUserDefaults standardUserDefaults];
    archivedArr = [[defToDo objectForKey:@"tasksArrr"]mutableCopy];
    tasksArry = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];
    //adding InProgressArray to NS defualt
    p = [NSKeyedArchiver archivedDataWithRootObject:inprogArry];
    [defToDo setObject:p forKey:@"archivedProgressArr"];
    //adding DoneArray to NS defualt
    l = [NSKeyedArchiver archivedDataWithRootObject:doneArry];
    [defToDo setObject:p forKey:@"archiveddoneArr"];
    //getting InProgressArray from NS defualt
   // defToDo = [NSUserDefaults standardUserDefaults];
    archivedInProgressArr = [[defToDo objectForKey:@"archivedProgressArr"]mutableCopy] ;
    inprogArry = [NSKeyedUnarchiver unarchiveObjectWithData:archivedInProgressArr];
    
    //getting doneArray from NS defualt
    //defToDo = [NSUserDefaults standardUserDefaults];
    archivedDoneArr = [[defToDo objectForKey:@"archiveddoneArr"]mutableCopy] ;
    inprogArry = [NSKeyedUnarchiver unarchiveObjectWithData:archivedDoneArr];
    
    
    //getting sellectedObject from userDefualts
//    defToDo = [NSUserDefaults standardUserDefaults];
//    archivedObject = [defToDo objectForKey:@"archivedObject"];
//    sellectedTask = [NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
//
    printf("viewWillAppear\n");
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    _titleTextViewEdit.text = self.viewDetailsOfSellectedCell.taskTitle ;
    _discriptionTextFiewEdit.text = self.viewDetailsOfSellectedCell.taskDiscription;
    _taskPriorityEdit.selectedSegmentIndex = [[_viewDetailsOfSellectedCell taskPeriority ]integerValue];
   _taskStatEdit.selectedSegmentIndex = [[_viewDetailsOfSellectedCell taskState]integerValue] ;
    
 
  //  -_taskStatEdit.selectedSegmentIndex= [[sellectedTask taskState]intValue];
    
}

- (IBAction)saveEditedObject:(id)sender {
    Tasks *sellectedTask = [Tasks new];
    sellectedTask.taskTitle =   _titleTextViewEdit.text ;
    sellectedTask.taskDiscription = _discriptionTextFiewEdit.text ;
    sellectedTask.taskPeriority = [NSNumber numberWithLong:_taskPriorityEdit.selectedSegmentIndex];
    sellectedTask.taskState = [ NSNumber numberWithLong:_taskStatEdit.selectedSegmentIndex];
    toDoViewController *toDoObj = [self.storyboard instantiateViewControllerWithIdentifier:@"toDoViewController"];
    InProgressViewController *inProgObj = [self.storyboard instantiateViewControllerWithIdentifier:@"InProgressViewController"];
    if(_arrayCommingFrom == @"1"){
        if([[sellectedTask taskState]isEqualToNumber:@0] ){
            // add object in todoarr tasksArry
            [tasksArry replaceObjectAtIndex:_indexNum withObject:sellectedTask];
        }else if ([[sellectedTask taskState]isEqualToNumber:@1]){
            //add object to InprogressArr
            [inprogArry addObject:sellectedTask];
            [tasksArry removeObjectAtIndex:_indexNum];
        }else if ([[sellectedTask taskState]isEqualToNumber:@2]){
            //add object to InprogressArr
            [doneArry addObject:sellectedTask];
            [tasksArry removeObjectAtIndex:_indexNum];
            
        }
    }else if (_arrayCommingFrom == @"2"){
        if([[sellectedTask taskState]isEqualToNumber:@0] ){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Note!" message:@"you can't return your task back into ToDo Tasks " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if ([[sellectedTask taskState]isEqualToNumber:@1]){
            // add object in inprogArr tasksArry
            [inprogArry replaceObjectAtIndex:_indexNum withObject:sellectedTask];
        }else if ([[sellectedTask taskState]isEqualToNumber:@2]){
            //add object to DoneArr
            [doneArry addObject:sellectedTask];
            [inprogArry removeObjectAtIndex:_indexNum];
        }
    }else if (_arrayCommingFrom == @"3"){
        if([[sellectedTask taskState]isEqualToNumber:@0] ){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Note!" message:@"you can't return your task back into ToDo Tasks " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if ([[sellectedTask taskState]isEqualToNumber:@1]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Note!" message:@"you can't return your task back into InProgress Tasks " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:yes];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if ([[sellectedTask taskState]isEqualToNumber:@2]){
            //add object to DoneArr
            [doneArry replaceObjectAtIndex:_indexNum withObject:sellectedTask];
        }
    }
        //adding taskArr to defualts
        NSData *d = [NSKeyedArchiver archivedDataWithRootObject:tasksArry];
        [defToDo setObject:d forKey:@"tasksArrr"];
        //adding inprogressArr to defualts
        NSData *p = [NSKeyedArchiver archivedDataWithRootObject:inprogArry];
        [defToDo setObject:p forKey:@"archivedProgressArr"];
        //adding doneArr to defualts
        NSData *v = [NSKeyedArchiver archivedDataWithRootObject:doneArry];
        [defToDo setObject:v forKey:@"archiveddoneArr"];
        [self.navigationController popViewControllerAnimated:YES];
        
   
}
        
        
        
        @end
        
    
    
    
