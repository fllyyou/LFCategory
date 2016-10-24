//
//  NSDictionary+LFAdd.h
//
//
//  Created by guoyaoyuan on 13-4-4.
//  Copyright (c) 2013 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_STATIC_INLINE BOOL NSDictionaryIsEmpty(NSDictionary *dictionary)
{
    if (dictionary && dictionary.count > 0 ) return NO;
    
    return YES;
}

/**
 Provide some some common method for `NSDictionary`.
 */
@interface NSDictionary (LFNSDictionaryAdditions)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 */
+ (NSDictionary *)lf_dictionaryWithPlistData:(NSData *)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (NSDictionary *)lf_dictionaryWithPlistString:(NSString *)plist;

/**
 Serialize the dictionary to a binary property list data.
 
 @return A binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
- (NSData *)lf_plistData;

/**
 Serialize the dictionary to a xml property list string.
 
 @return A plist xml string, or nil if an error occurs.
 */
- (NSString *)lf_plistString;

/// 返回所有key (按字典序排列)
- (NSArray *)lf_allKeysSorted;

/// 返回所有value (按key的字典序排列)
- (NSArray *)lf_allValuesSortedByKeys;

/// 是否包含 key
- (BOOL)lf_containsObjectForKey:(id)key;

/// 根据一组 key 来取对象
- (NSDictionary *)lf_entriesForKeys:(NSArray *)keys;

/// 编码为 json 字符串。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonStringEncoded;

/// 编码为 json 字符串(带格式)。 如果出错则返回nil。 内容支持NSString/NSNumber/NSDictionary/NSArray
- (NSString *)lf_jsonPrettyStringEncoded;

/**
 尝试解析 XML，并包装为 dictionary。
 如果你只是想从一个小xml里取一个值，可以试试这个方法

 example XML: "<config><a href="test.com">link</a></config>"
 example Return: @{@"_name":@"config", @"a":{@"_text":@"link",@"href":@"test.com"}}
 
 @param xmlDataOrString XML in NSData or NSString format.
 
 @return Return a new dictionary, or nil if an error occurs.
 */
+ (NSDictionary *)lf_dictionaryWithXML:(id)xmlDataOrString;

@end



/**
 Provide some some common method for `NSMutableDictionary`.
 */
@interface NSMutableDictionary (LFNSMutableDictionaryAdditions)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (NSMutableDictionary *)lf_dictionaryWithPlistData:(NSData *)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 */
+ (NSMutableDictionary *)lf_dictionaryWithPlistString:(NSString *)plist;

/// 移除并返回一个对象
- (id)lf_popObjectForKey:(id)aKey;

/// 移除并返回一组对象
- (NSDictionary *)lf_popEntriesForKeys:(NSArray *)keys;

@end
