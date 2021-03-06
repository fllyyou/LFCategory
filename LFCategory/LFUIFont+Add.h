//
//  UIFont+LFAdd.h
//
//
//  Created by guoyaoyuan on 14-5-11.
//  Copyright (c) 2014 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>

/**
 Provides extensions for `UIFont`.
 */
@interface UIFont (LFAdditions) <NSCoding>

#pragma mark - Font Traits
///=============================================================================
/// @name Font Traits
///=============================================================================

@property (nonatomic, readonly) BOOL lf_isBold NS_AVAILABLE_IOS(7_0); ///< Whether the font is bold.
@property (nonatomic, readonly) BOOL lf_isItalic NS_AVAILABLE_IOS(7_0); ///< Whether the font is italic.
@property (nonatomic, readonly) BOOL lf_isMonoSpace NS_AVAILABLE_IOS(7_0); ///< Whether the font is mono space.
@property (nonatomic, readonly) BOOL lf_isColorGlyphs NS_AVAILABLE_IOS(7_0); ///< Whether the font is color glyphs (such as Emoji).
@property (nonatomic, readonly) CGFloat lf_fontWeight NS_AVAILABLE_IOS(7_0); ///< Font weight from -1.0 to 1.0. Regular weight is 0.0.

/**
 Create a bold font from receiver.
 @return A bold font, or nil if failed.
 */
- (UIFont *)lf_fontWithBold NS_AVAILABLE_IOS(7_0);

/**
 Create a italic font from receiver.
 @return A italic font, or nil if failed.
 */
- (UIFont *)lf_fontWithItalic NS_AVAILABLE_IOS(7_0);

/**
 Create a bold and italic font from receiver.
 @return A bold and italic font, or nil if failed.
 */
- (UIFont *)lf_fontWithBoldItalic NS_AVAILABLE_IOS(7_0);

/**
 Create a normal (no bold/italic/...) font from receiver.
 @return A normal font, or nil if failed.
 */
- (UIFont *)lf_fontWithNormal NS_AVAILABLE_IOS(7_0);

#pragma mark - Create font
///=============================================================================
/// @name Create font
///=============================================================================

/**
 Creates and returns a font object for the specified CTFontRef.
 
 @param CTFont  CoreText font.
 */
+ (UIFont *)lf_fontWithCTFont:(CTFontRef)CTFont;

/**
 Creates and returns a font object for the specified CGFontRef and size.
 
 @param CGFont  CoreGraphic font.
 @param size    Font size.
 */
+ (UIFont *)lf_fontWithCGFont:(CGFontRef)CGFont size:(CGFloat)size;

/**
 Creates and returns the CTFontRef object. (need call CFRelease() after used)
 */
- (CTFontRef)lf_CTFontRef CF_RETURNS_RETAINED;

/**
 Creates and returns the CGFontRef object. (need call CFRelease() after used)
 */
- (CGFontRef)lf_CGFontRef CF_RETURNS_RETAINED;


#pragma mark - Load and unload font
///=============================================================================
/// @name Load and unload font
///=============================================================================

/**
 Load the font from file path. Support format:TTF,OTF.
 If return YES, font can be load use it PostScript Name: [UIFont fontWithName:...]
 
 @param path    font file's full path
 */
+ (BOOL)lf_loadFontFromPath:(NSString *)path;

/**
 Unload font from file path.
 
 @param path    font file's full path
 */
+ (void)lf_unloadFontFromPath:(NSString *)path;

/**
 Load the font from data. Support format:TTF,OTF.
 
 @param data  Font data.
 
 @return UIFont object if load succeed, otherwise nil.
 */
+ (UIFont *)lf_loadFontFromData:(NSData *)data;

/**
 Unload font which is loaded by loadFontFromData: function.
 
 @param font the font loaded by loadFontFromData: function
 
 @return YES if succeed, otherwise NO.
 */
+ (BOOL)lf_unloadFontFromData:(UIFont *)font;


#pragma mark - Dump font data
///=============================================================================
/// @name Dump font data
///=============================================================================

/**
 Serialize and return the font data.
 
 @param font The font.
 
 @return data in TTF, or nil if an error occurs.
 */
+ (NSData *)lf_dataFromFont:(UIFont *)font;

/**
 Serialize and return the font data.
 
 @param cgFont The font.
 
 @return data in TTF, or nil if an error occurs.
 */
+ (NSData *)lf_dataFromCGFont:(CGFontRef)cgFont;


- (CGFloat)lf_lineHeight;
@end
