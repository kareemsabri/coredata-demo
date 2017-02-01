//
//  Task+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by Kareem Sabri on 2017-02-01.
//  Copyright © 2017 Kareem Sabri. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Task"];
}

@dynamic title;
@dynamic isDone;
@dynamic createdOn;

@end
