//
//  NSArray+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/**
 Provide some some common method for `NSArray`.
 */
@interface NSArray (LFNSArrayAdditions)

/**
 Creates and returns an array from a specified property list data.
 
 @param plist   A property list data whose root object is an array.
 @return A new array created from the binary plist data, or nil if an error occurs.
 */
+ (nullable NSArray *)lf_arrayWithPlistData:(NSData *)plist;

/**
 Creates and returns an array from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is an array.
 @return A new array created from the plist string, or nil if an error occurs.
 */
+ (nullable NSArray *)lf_arrayWithPlistString:(NSString *)plist;

/**
 Serialize the array to a binary property list data.
 
 @return A binary plist data, or nil if an error occurs.
 */
- (nullable NSData *)lf_plistData;

/**
 Serialize the array to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (nullable NSString *)lf_plistString;


/// 随机返回一个对象 (如果Array空，则返回nil)
- (nullable id)lf_randomObject;

/// 和 `objectAtIndex:` 类似，但超出范围不会抛异常
- (nullable id)lf_objectOrNilAtIndex:(NSUInteger)index;

/// 编码为 json 字符串。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (nullable NSString *)lf_jsonStringEncoded;

/// 编码为 json 字符串(带格式)。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (nullable NSString *)lf_jsonPrettyStringEncoded;

@end

NS_ASSUME_NONNULL_END
