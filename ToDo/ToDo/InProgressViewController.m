//
//  InProgressViewController.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "InProgressViewController.h"
#import "toDoViewController.h"
#import "Tasks.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"
@interface InProgressViewController ()

@end

@implementation InProgressViewController
{
    Tasks *task;
    Tasks *sellectedTask;
    NSUserDefaults *defToDo;
    NSData *archivedProgressArr;
    NSData *archivedObject;
    int priortyy;
    NSMutableArray *LpriortyArr;
    NSMutableArray *MpriortyArr;
    NSMutableArray *HpriortyArr;
    NSUInteger numOfRows;
   
    //NSIndexPath *sellctedObjectIndex;
    int i;
   // NSMutableArray *progressArr;
    
}
static  NSMutableArray *progressArr;

+(void)initialize{
    progressArr = [NSMutableArray new];

}
- (void)viewDidLoad {
    //progressArr = [NSMutableArray new];
    [super viewDidLoad];

    task = [Tasks new];
    sellectedTask = [Tasks new];
    printf("viewdidload\n");
    //adding Array to NSDefualt
   
    //[tasksArr addObject:task];
   /* archivedProgressArr = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
    [defToDo setObject:archivedProgressArr forKey:@"archivedProgressArr"];*/


}
- (void)viewWillAppear:(BOOL)animated{
    priortyy = 3;
    LpriortyArr = [NSMutableArray new];
    MpriortyArr= [NSMutableArray new];
    HpriortyArr= [NSMutableArray new];
    //getting InProgressArray from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archivedProgressArr = [[defToDo objectForKey:@"archivedProgressArr"]mutableCopy];
    progressArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedProgressArr];
    numOfRows = [progressArr count];
    [_inporogreesTableView reloadData];

}
- (void)viewDidAppear:(BOOL)animated{
    // deviding inprogArr into 3 priorties
    for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 0){
            [LpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 1){
            [MpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 2){
            [HpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
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
            numOfRows = [progressArr count];
            
    }
    return numOfRows;
}
- (IBAction)priortyFilterSegment:(id)sender {
    if(_priortyFilterSegment.selectedSegmentIndex == 0) {
        priortyy = 0;
    }else if (_priortyFilterSegment.selectedSegmentIndex == 1){
        priortyy = 1;
    }else if (_priortyFilterSegment.selectedSegmentIndex == 2){
        priortyy = 2;
    }
   /* for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 0){
            [LpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 1){
            [MpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
    }
    for(i=0 ; i < [progressArr count] ; i++){
        if( [[[progressArr objectAtIndex:i]taskPeriority]integerValue] == 2){
            [HpriortyArr addObject:[progressArr objectAtIndex:i]];
        }
        
    }*/
    [_inporogreesTableView reloadData];
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InProgressCell" forIndexPath:indexPath];
    if(  priortyy  ==  3 ){
        
        cell.textLabel.text = [[progressArr objectAtIndex:indexPath.row] taskTitle];
        cell.imageView.image=[UIImage imageNamed:[[[progressArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
        
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"delete" message:@"are you sure you want to remove!! " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [progressArr removeObjectAtIndex:indexPath.row];
        //adding inprogressArr to defualts
        NSData *p = [NSKeyedArchiver archivedDataWithRootObject:progressArr];
        [self->defToDo setObject:p forKey:@"archivedProgressArr"];
        [_inporogreesTableView reloadData];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:nil];  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *editViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    editViewC.indexNum = indexPath.row;
    editViewC.arrayCommingFrom = @"2";
    sellectedTask.taskTitle = [[progressArr objectAtIndex:indexPath.row] taskTitle ];
    
    sellectedTask.taskDiscription = [[progressArr objectAtIndex:indexPath.row]taskDiscription];
    //sellectedTask.taskState = [[progressArr objectAtIndex:indexPath.row]taskState];
    sellectedTask.taskPeriority =[[progressArr objectAtIndex:indexPath.row]taskPeriority];
    //show object attributes in editView
    editViewC.viewDetailsOfSellectedCell = sellectedTask;
    //adding taskObject to defualts
    archivedObject = [NSKeyedArchiver archivedDataWithRootObject:sellectedTask];
    [defToDo setObject:archivedObject forKey:@"archivedObject"];
    
    [self.navigationController pushViewController:editViewC  animated:YES];
    
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
