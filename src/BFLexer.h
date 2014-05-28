#import <Foundation/Foundation.h>

@interface BFLexer : NSObject
{
    unichar * _code;
    NSUInteger _codeLength;
    NSUInteger _codePosition;

    unichar * _currentLexeme;
    NSUInteger _currentLexemeLength;
    NSUInteger _currentLexemePosition;

    NSMutableArray * _tokens;

    NSUInteger _currentLine;
    NSUInteger _currentColumn;

    unichar _currentChar;
    unichar _next1Char;

    BOOL _done;
}

- (id)init;
- (void)dealloc;

- (void)setSourceCodeWithContentsOfFile:(NSString *)path;
- (void)setSourceCodeWithString:(NSString *)string;

- (void)lex;

@property (readonly) NSArray * tokens;

@end


