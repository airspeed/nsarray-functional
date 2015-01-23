//
//  NSArray+Functional.h
//  clixxie
//
//  Created by Fran Pugl on 22/01/15.
//  Copyright (c) 2015 femory GmbH & Co KG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Functional)
@property (nonatomic, strong, readonly) id head;
@property (nonatomic, strong, readonly) NSArray *tail;
@property (nonatomic, strong, readonly) id secondObject;
-(NSArray *)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(NSArray *)moveObjectToLastIndexFromIndex:(NSUInteger)fromIndex;
-(NSArray *)moveToLastIndexObject:(id)object;
-(NSArray *)reverse;
-(NSArray *)take:(NSUInteger)length;
-(NSArray *)drop:(NSUInteger)length;
@end
