//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Kareem Sabri on 2017-01-31.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Task+CoreDataClass.h"
@import CoreData;

@interface ViewController ()
@property (nonatomic,retain) NSMutableArray<Task*> *myTasks;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *taskTitleField;
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;
//the two properties below are convenience properties so we don't have to
//fetch these every time
//they are used for reading and writing from the database
@property (nonatomic) AppDelegate* delegate;
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set application delegate - this is used to get the managed object context, and save objects to the database
    self.delegate = [UIApplication sharedApplication].delegate;
    //set context - objects are inserted into context, this is
    self.context = self.delegate.persistentContainer.viewContext;
    //fetch data on load
    [self fetchTasks];
}

- (IBAction)didTapSaveButton:(UIButton *)sender {
    //first we ensure they've written something in the field
    if (self.taskTitleField.text != nil) {
        //create a new tasks - we have to use the insertNewObjectForEntityForName method to get a new NSManagedObject subclass instance in the context
        Task *myNewTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:self.context];
        //set the values we want
        myNewTask.title = self.taskTitleField.text;
        myNewTask.createdOn = [[NSDate alloc] init];
        //tell the delegate to save the context
        [self.delegate saveContext];
        //once it's saved, add it to our tasks array
        [self.myTasks addObject:myNewTask];
        //reset the field and resign first responder to hide the keybaord
        self.taskTitleField.text = nil;
        [self.taskTitleField resignFirstResponder];
        //refresh table
        [self.tasksTable reloadData];
    }
}

-(void)fetchTasks {
    //create a fetch request to fetch Tasks
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    //create an error pointer to hold the error from fetch request, if happens
    NSError *error;
    //tell the context to execute the fetch request, and save it to an array of results
    NSArray *tasks = [self.context executeFetchRequest:request error:&error];
    //assign the results to our property array
    self.myTasks = [tasks mutableCopy];
    //reload the table data since we've fetched tasks
    [self.tasksTable reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myTasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //get a task for this cell - we display them in same order as the array
    Task *taskForCell = self.myTasks[indexPath.row];
    //deque a cell to display the task
    UITableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    //set the text to the task title
    taskCell.textLabel.text = taskForCell.title;
    //we will show a checkmark if the task is completed
    if (taskForCell.isDone) {
        taskCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        taskCell.accessoryType = UITableViewCellAccessoryNone;
    }
    return taskCell;
}


@end
