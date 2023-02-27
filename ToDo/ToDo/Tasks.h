//
//  Tasks.h
//  ToDo
//
//  Created by Ahmed Fekry on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tasks : NSObject <NSCoding>

@property NSString *taskTitle;
@property NSString *taskDiscription;
@property NSNumber *taskPeriority; // 2=H 1=M 0=L
@property NSNumber *taskState;
@property NSDate *taskCreationDate;


- (void)encodeWithCoder:(nonnull NSCoder *)coder;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder;
@end

NS_ASSUME_NONNULL_END
