#import <Foundation/Foundation.h>

// Log function
#if defined(ENABLE_KLOGGING)
#   define __log(__FORMAT__, ...) do { NSLog(@"(dump)[%s:%d] "__FORMAT__, __FILE__, __LINE__, __VA_ARGS__); } while (NO)
#else
#   define __log(__FORMAT__, ...)
#endif

// Raw dump functions
#define __dump_variable(__TYPE__, __VAR_NAME__, __VAL_FORMAT__, ...) __log("%s %s = "__VAL_FORMAT__, __TYPE__, __VAR_NAME__, __VA_ARGS__)
#define __dump_variable_ptr(__TYPE__, __ADDRESS__, __VAR_NAME__, __VAL_FORMAT__, ...) __log("%s * %s at %p = "__VAL_FORMAT__, __TYPE__, __VAR_NAME__, __ADDRESS__, __VA_ARGS__)

// Wrappers for basic types
#define dump_bool(__VAR__) __dump_variable("BOOL", #__VAR__, "%s", __VAR__ ? "YES" : "NO")
#define dump_char(__VAR__) __dump_variable("char", #__VAR__, "%f", __VAR__)
#define dump_unichar(__VAR__) __dump_variable("unichar", #__VAR__, "%c", __VAR__)
#define dump_cstring(__VAR__) __dump_variable_ptr("char", __VAR__, #__VAR__, "%C", __VAR__)
#define dump_cunistring(__VAR__) __dump_variable_ptr("unichar", __VAR__, #__VAR__, "%S", __VAR__)
#define dump_float(__VAR__) __dump_variable("float", #__VAR__, "%f", __VAR__)
#define dump_int(__VAR__) __dump_variable("int", #__VAR__, "%i", __VAR__)

// Wrapper for objects
#define __dump_object(__TYPE__, __VAR__) __dump_variable_ptr(__TYPE__, __VAR__, #__VAR__, "%@", (__VAR__ ? [__VAR__ prettyDescription] : @"nil"))
#define dump_array(__VAR__) __dump_object("NSArray", __VAR__)
#define dump_dictionary(__VAR__) __dump_object("NSDictionary", __VAR__)
#define dump_object(__VAR__) __dump_object((__VAR__ ? [[__VAR__ className] UTF8String] : "NSObject"), __VAR__)
#define dump_string(__VAR__) __dump_object("NSString", __VAR__)

// Some helpers
@interface NSObject (KLogging)
- (NSString *)prettyDescription;
@end

@interface NSArray (KLogging)
- (NSString *)prettyDescription;
@end

@interface NSDictionary (KLogging)
- (NSString *)prettyDescription;
@end

@interface NSString (KLogging)
- (NSString *)prettyDescription;
@end