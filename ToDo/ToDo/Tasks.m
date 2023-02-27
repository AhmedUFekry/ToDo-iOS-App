//
//  Tasks.m
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import "Tasks.h"

@implementation Tasks




- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_taskTitle forKey:@"taskTitle"];
    [coder encodeObject:_taskDiscription forKey:@"taskDiscription"];
    [coder encodeObject:_taskPeriority forKey:@"taskPeriority"];
    [coder encodeObject:_taskState forKey:@"taskState"];
    [coder encodeInteger:_taskCreationDate forKey:@"taskCreationDate"];


}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    self.taskTitle = [coder decodeObjectForKey:@"taskTitle"];
    self.taskDiscription = [coder decodeObjectForKey:@"taskDiscription"];
    self.taskPeriority = [coder decodeObjectForKey:@"taskPeriority"];
    self.taskState =[coder decodeObjectForKey:@"taskState"];
    self.taskCreationDate = [coder decodeObjectForKey:@"taskCreationDate"];
    return self;


}

@end
