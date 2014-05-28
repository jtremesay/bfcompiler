#import "KLogging.h"

static NSUInteger sIndentLevel = 0;
static NSString * generateIndent(NSUInteger level)
{
    NSMutableString * indent = [NSMutableString stringWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [indent appendString:@"\t"];
    }

    return indent;
}

@implementation NSObject (KLogging)
- (NSString *)prettyDescription
{
    return [self description];
}
@end

@implementation NSArray (KLogging)
- (NSString *)prettyDescription
{
    NSMutableString * description = [NSMutableString stringWithCapacity:4096];
    [description appendString:@"[\n"];
    sIndentLevel++;
    for(id object in self) {
        [description appendString:generateIndent(sIndentLevel)];
        [description appendString:[object prettyDescription]];
        [description appendString:@",\n"];
    }
    sIndentLevel--;
    [description appendString:generateIndent(sIndentLevel)];
    [description appendString:@"] ("];
    [description appendFormat:@"%d", self.count];
    [description appendString:@" elements)"];

    return description;
}
@end

@implementation NSDictionary (KLogging)
- (NSString *)prettyDescription
{
    NSMutableString * description = [NSMutableString stringWithCapacity:4096];
    [description appendString:@"[\n"];
    sIndentLevel++;
    for(id key in self) {
        id value = [self objectForKey:key];

        [description appendString:generateIndent(sIndentLevel)];
        [description appendString:[key prettyDescription]];
        [description appendString:@" => "];
        [description appendString:[value prettyDescription]];
        [description appendString:@",\n"];
    }
    sIndentLevel--;
    [description appendString:generateIndent(sIndentLevel)];
    [description appendString:@"] ("];
    [description appendFormat:@"%d", self.count];
    [description appendString:@" elements)"];

    return description;
}
@end

@implementation NSString (KLogging)
- (NSString *)prettyDescription
{
    NSMutableString * description = [NSMutableString stringWithCapacity:4096];
    [description appendString:@"@\""];
    [description appendString:[self description]];
    [description appendString:@"\" ("];
    [description appendFormat:@"%d", self.length];
    [description appendString:@"characters)"];

    return description;
}
@end