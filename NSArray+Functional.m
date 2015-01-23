//
//  NSArray+Functional.m
//  clixxie
//
//  Created by Fran Pugl on 22/01/15.
//  Copyright (c) 2015 femory GmbH & Co KG. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

-(id)head
{
    return self.firstObject;
}

-(NSArray *)tail
{
    if ( self.count > 1 )
        return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
    else
        return @[];
}

-(NSArray *)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if ( toIndex > self.count )
    {
        NSString *message = @"IndexOutOfRangeException: NSArray does not contain index ";
        NSLog(@"%@ %ul.", message, toIndex);
        return [NSArray arrayWithObject:@(raise(1))];
    }
    else if ( self.count < 2 || fromIndex == toIndex )
    {
        return self;
    }
    else if ( fromIndex < toIndex )
    {
        if ( fromIndex == 0 )
        {
            if ( toIndex == 0 )
                return self;
            else
            {
                NSArray *newTail = [[NSArray arrayWithObject:self.head] concat:self.tail.tail];
                return [[NSArray arrayWithObject:self.tail.head] concat:[newTail moveObjectFromIndex:fromIndex toIndex:toIndex - 1]];
            }
        }
        else
            return [[NSArray arrayWithObject:self.head] concat:[self.tail moveObjectFromIndex:fromIndex - 1 toIndex:toIndex - 1]];
    }
    else
    {
        NSArray *reversedArray = [self reverse];
        NSUInteger newFromIndex = self.count - fromIndex - 1;
        NSUInteger newToIndex = self.count - toIndex - 1;
        NSArray *resultArray = [reversedArray moveObjectFromIndex:newFromIndex toIndex:newToIndex];
        return [resultArray reverse];
    }
}

-(NSArray *)moveObjectToLastIndexFromIndex:(NSUInteger)fromIndex
{
    return [self moveObjectFromIndex:fromIndex toIndex:self.count - 1];
}

-(NSArray *)moveToLastIndexObject:(id)object
{
    NSUInteger currentIndex = [self indexOfObject:object];
    if ( currentIndex == NSNotFound )
        return self;
    return [self moveObjectToLastIndexFromIndex:currentIndex];
}

-(NSArray *)concat:(NSArray *)array
{
    return [self arrayByAddingObjectsFromArray:array];
}

-(id)secondObject
{
    return self.tail.head;
}

-(NSArray *)reverse
{
    if ( self.count < 2 )
        return self;
    else
        return [[self.tail reverse] concat:[NSArray arrayWithObject:self.head]];
}

-(NSArray *)take:(NSUInteger)length
{
    if ( length >= self.count )
        return self;
    else
        return [self take:length count:0];
}

-(NSArray *)take:(NSUInteger)length count:(NSUInteger)count
{
    if ( count == length )
        return @[];
    else
        return [[NSArray arrayWithObject:self.head] concat:[self.tail take:length count:count + 1]];
}

-(NSArray *)drop:(NSUInteger)length
{
    if ( length >= self.count )
        return @[];
    else
        return [self drop:length count:0];
}

-(NSArray *)drop:(NSUInteger)length count:(NSUInteger)count
{
    if ( count == length )
        return self;
    else
        return [self.tail drop:length count:count + 1];
}

@end
