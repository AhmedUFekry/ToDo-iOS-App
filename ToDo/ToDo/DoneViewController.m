//
//  DoneViewController.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "DoneViewController.h"
#import "InProgressViewController.h"
#import "toDoViewController.h"
#import "Tasks.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController
{
    Tasks *task;
    Tasks *sellectedTask;
    NSUserDefaults *defToDo;
    NSData *archiveddoneArr;
    NSData *archivedObject;
    int priortyy;
    NSUInteger numOfRows;
     NSMutableArray *LpriortyArr;
     NSMutableArray *MpriortyArr;
     NSMutableArray *HpriortyArr;
    //NSIndexPath *sellctedObjectIndex;
    int i;
   // NSMutableArray *doneArr;
}
static  NSMutableArray *doneArr;

+(void)initialize{
    doneArr = [NSMutableArray new];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    task = [Tasks new];
    sellectedTask = [Tasks new];
    printf("viewdidload\n");
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    LpriortyArr = [NSMutableArray new];
    MpriortyArr= [NSMutableArray new];
    HpriortyArr= [NSMutableArray new];
    priortyy = 3;
    //getting IndoneArray from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archiveddoneArr = [[defToDo objectForKey:@"archiveddoneArr"]mutableCopy];
    doneArr = [NSKeyedUnarchiver unarchiveObjectWithData:archiveddoneArr];
    [_doneTableV reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    // deviding inprogArr into 3 priorties
    for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 0){
            [LpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 1){
            [MpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 2){
            [HpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
        
    }
}
    
- (IBAction)donePriortySegments:(id)sender {
    if(_donePriortySegment.selectedSegmentIndex == 0) {
        priortyy = 0;
    }else if (_donePriortySegment.selectedSegmentIndex == 1){
        priortyy = 1;
    }else if (_donePriortySegment.selectedSegmentIndex == 2){
        priortyy = 2;
    }
   /* for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 0){
            [LpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 1){
            [MpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [doneArr count] ; i++){
        if( [[[doneArr objectAtIndex:i]taskPeriority]integerValue] == 2){
            [HpriortyArr addObject:[doneArr objectAtIndex:i]];
        }
        
    }*/
    [_doneTableV reloadData];
}

    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        switch(priortyy){
            case 0:
                numOfRows = [LpriortyArr count];
                break;
            case 1:
                numOfRows = [MpriortyArr count];
                break;
            case 2:
                numOfRows = [HpriortyArr count];
                break;
            case 3:
                numOfRows = [doneArr count];
                
        }
        return numOfRows;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneCell" forIndexPath:indexPath];
        
        if(  priortyy  ==  3 ){
            
            cell.textLabel.text = [[doneArr objectAtIndex:indexPath.row] taskTitle];
            cell.imageView.image=[UIImage imageNamed:[[[doneArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
            
        }
        if(  priortyy  ==  0 ){
            
            cell.textLabel.text = [[LpriortyArr objectAtIndex:indexPath.row] taskTitle];
            cell.imageView.image=[UIImage imageNamed:[[[LpriortyArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
            
           
        }
        
        if(  priortyy  ==  1 ){
            
            cell.textLabel.text = [[MpriortyArr objectAtIndex:indexPath.row] taskTitle];
            cell.imageView.image=[UIImage imageNamed:[[[MpriortyArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
          
        }
        
        if(  priortyy  ==  2 ){
            
            cell.textLabel.text = [[HpriortyArr objectAtIndex:indexPath.row] taskTitle];
            cell.imageView.image=[UIImage imageNamed:[[[HpriortyArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
            
        }
        
            return cell;
        
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *editViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    editViewC.indexNum = indexPath.row;
    editViewC.arrayCommingFrom = @"3";
    sellectedTask.taskTitle = [[doneArr objectAtIndex:indexPath.row] taskTitle ];
    
    sellectedTask.taskDiscription = [[doneArr objectAtIndex:indexPath.row]taskDiscription];
    //sellectedTask.taskState = [[doneArr objectAtIndex:indexPath.row]taskState];
    sellectedTask.taskPeriority =[[doneArr objectAtIndex:indexPath.row]taskPeriority];
    //show object attributes in editView
    editViewC.viewDetailsOfSellectedCell = sellectedTask;
    //adding taskObject to defualts
    archivedObject = [NSKeyedArchiver archivedDataWithRootObject:sellectedTask];
    [defToDo setObject:archivedObject forKey:@"archivedObject"];
    
    [self.navigationController pushViewController:editViewC  animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"delete" message:@"are you sure you want to remove!! " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [doneArr removeObjectAtIndex:indexPath.row];
        //adding indoneArr to defualts
        NSData *p = [NSKeyedArchiver archivedDataWithRootObject:doneArr];
        [self->defToDo setObject:p forKey:@"archiveddoneArr"];
        [_doneTableV reloadData];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:nil];
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
