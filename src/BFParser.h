#import <Foundation/Foundation.h>

@class BFNodeProgram;

@interface BFParser : NSObject
{
    NSArray * _tokens;
}

- (void)dealloc;
- (BFNodeProgram *)parse;

@property (retain) NSArray * tokens;

@end