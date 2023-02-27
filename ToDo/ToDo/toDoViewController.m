//
//  toDoViewController.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "toDoViewController.h"
#import "Tasks.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"

@interface toDoViewController ()

@end

@implementation toDoViewController
{
    Tasks *task;
    Tasks *sellectedTask;
    NSUserDefaults *defToDo;
    NSData *archivedArr;
    NSData *archivedObject;
    NSMutableArray *searchResultArr;
    NSUInteger numOfRows;
    NSUInteger searchSwitch;


   
    //NSIndexPath *sellctedObjectIndex;
    int i;
    
    
}
static  NSMutableArray *tasksArr;
+(void)initialize{
    tasksArr = [NSMutableArray new];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //adding Array to NSDefualt
    //tasksArr = [NSMutableArray new];
    task = [Tasks new];
    sellectedTask = [Tasks new];
    printf("viewdidload\n");
    //adding Array to NSDefualt
    defToDo = [NSUserDefaults standardUserDefaults];
    //tasksArr = [NSMutableArray new];
    //[tasksArr addObject:task];
    if([defToDo objectForKey:@"tasksArrr"] == nil){
        archivedArr = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [defToDo setObject:archivedArr forKey:@"tasksArrr"];
    }
    //adding taskObject to defualts
//    archivedObject = [NSKeyedArchiver archivedDataWithRootObject:sellectedTask];
//    [defToDo setObject:archivedObject forKey:@"archivedObject"];
//
    
   /* [tasksArr addObject:task];
    archivedArr =[NSKeyedArchiver archivedDataWithRootObject:tasksArr];
    [defToDo setObject:archivedArr forKey:@"tasksArrr"];
    */
   // [_toDoTable reloadData];

    
}
- (void)viewWillAppear:(BOOL)animated{
    searchResultArr = [NSMutableArray new];
    searchSwitch = 0;

    //getting Array from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archivedArr = [[defToDo objectForKey:@"tasksArrr"] mutableCopy];
    tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];
    //getting sellectedObject from userDefualts
//    defToDo = [NSUserDefaults standardUserDefaults];
//    archivedObject = [defToDo objectForKey:@"archivedObject"];
//    sellectedTask = [NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
    printf("viewWillAppear\n");
    
    
 


}
- (void)viewDidAppear:(BOOL)animated{
    [_toDoTable reloadData];
    printf("viewDidAppear\n");
    
}

    
- (IBAction)addNewTaskButton:(id)sender {
    
    AddTaskViewController *addTaskViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    [self.navigationController pushViewController:addTaskViewC animated:YES]   ;//ماتنساش تغيد ال complition ، تحط انه يجع اللي في ال textfield ، textview لل todoView
}

- (IBAction)SearchButton:(id)sender {
    for (i=0; i<[tasksArr count]; i++) {
        if(_searchTextField.text == [[tasksArr objectAtIndex:i]taskTitle]){
            [searchResultArr addObject:[tasksArr objectAtIndex:i]];
        }
    }
    searchSwitch = 1;
    [_toDoTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    printf("numberOfSectionsInTableView/n");
    return 1;
    //[tasksArr count]
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch(searchSwitch){
        case 0:
            numOfRows = [tasksArr count];
            break;
        case 1:
            numOfRows = [searchResultArr count];
    }
    printf("numberOfRowsInSection\n");
    return numOfRows;//[tasksArr count] ;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    if(searchSwitch == 0){
        cell.textLabel.text = [[tasksArr objectAtIndex:indexPath.row] taskTitle ];
        cell.imageView.image=[UIImage imageNamed:[[[tasksArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
        cell.detailTextLabel.text = [[tasksArr objectAtIndex:indexPath.row] taskCreationDate ] ;
        printf("cellForRowAtIndexPath\n");
    }else if (searchSwitch == 1){
        cell.textLabel.text = [[searchResultArr objectAtIndex:indexPath.row] taskTitle ];
        cell.imageView.image=[UIImage imageNamed:[[[searchResultArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
        cell.detailTextLabel.text = [[searchResultArr objectAtIndex:indexPath.row] taskCreationDate ] ;
        printf("cellForRowAtIndexPath\n");
    }
    
   
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *editViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    editViewC.indexNum = indexPath.row;
        
    editViewC.arrayCommingFrom = @"1";
    sellectedTask.taskTitle = [[tasksArr objectAtIndex:indexPath.row] taskTitle ];
    
    sellectedTask.taskDiscription = [[tasksArr objectAtIndex:indexPath.row]taskDiscription];
    //sellectedTask.taskState = [[tasksArr objectAtIndex:indexPath.row]taskState];
    sellectedTask.taskPeriority =[[tasksArr objectAtIndex:indexPath.row]taskPeriority];
    
    //show object attributes in editView
   /* editViewC.viewDetailsOfSellectedCell.taskTitle =sellectedTask.taskTitle;
    editViewC.viewDetailsOfSellectedCell.taskDiscription =sellectedTask.taskDiscription;
    editViewC.viewDetailsOfSellectedCell.taskState =sellectedTask.taskState;
    editViewC.viewDetailsOfSellectedCell.taskPeriority =sellectedTask.taskPeriority; */
    editViewC.viewDetailsOfSellectedCell = sellectedTask;



    
    //adding taskObject to defualts
    archivedObject = [NSKeyedArchiver archivedDataWithRootObject:sellectedTask];
    [defToDo setObject:archivedObject forKey:@"archivedObject"];
    
    [self.navigationController pushViewController:editViewC  animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"delete" message:@"are you sure you want to remove!! " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [tasksArr removeObjectAtIndex:indexPath.row];
        
        self->archivedObject = [NSKeyedArchiver archivedDataWithRootObject:self->sellectedTask];
        [self->defToDo setObject:self->archivedObject forKey:@"archivedObject"];
        
       NSData *d = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [defToDo setObject:d forKey:@"tasksArrr"];
        
       
        [self->_toDoTable reloadData];
       // [_toDoTable reloadData];
        
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
