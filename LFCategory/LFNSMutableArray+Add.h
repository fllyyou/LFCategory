//
//  NSMutableArray+Add.h
//  LFCategory
//
//  Created by WangZhiWei on 16/5/19.
//  Copyright © 2016年 youku. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provide some some common method for `NSMutableArray`.
 */
@interface NSMutableArray (LFNSMutableArrayAdditions)

/**
 Creates and returns an array from a specified property list data.
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (NSMutableArray *)arrayWithPlistData:(NSData *)plist;

/**
 Creates and returns an array from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (NSMutableArray *)arrayWithPlistString:(NSString *)plist;



/// 移除第一个对象 (如果Array空，则无效果)
- (void)lf_removeFirstObject;

/// 移除最后一个对象 (如果Array空，则无效果)
- (void)lf_removeLastObject;

/// 移除第一个对象并返回 (如果Array空，则无效果)
- (id)lf_popFirstObject;

/// 移除最后一个对象并返回 (如果Array空，则无效果)
- (id)lf_popLastObject;

/// 在结尾添加对象 (不能为nil)
- (void)appendObject:(id)anObject;

/// 在开头添加对象 (不能为nil)
- (void)lf_prependObject:(id)anObject;

/// 在结尾添加一批对象 (可以为nil)
- (void)appendObjects:(NSArray *)objects;

/// 在开头添加一批对象 (可以为nil)
- (void)lf_prependObjects:(NSArray *)objects;

/// 在某个位置添加一批对象 (index不能超出范围)
- (void)lf_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/// 反转对象顺序，例如 @[ @1, @2, @3 ] -> @[ @3, @2, @1 ].
- (void)lf_reverse;

/// 随机排列对象顺序 (洗牌)
- (void)lf_shuffle;

/// 添加一个对象，可以为nil。当是NSNull时，不会被添加。
- (void)lf_appendObject:(id)anObject;

- (void)lf_appendObjects:(NSArray*)objects;

@end
