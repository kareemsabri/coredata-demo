//
//  Task+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by Kareem Sabri on 2017-02-01.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Task+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) BOOL isDone;
@property (nullable, nonatomic, copy) NSDate *createdOn;

@end

NS_ASSUME_NONNULL_END
