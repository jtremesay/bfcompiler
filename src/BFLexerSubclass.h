#import "BFLexer.h"

@interface BFLexer (protected)
- (void)addCharToCurrentLexeme:(unichar)c;
- (NSString *)popCurrentLexeme;
- (void)shift:(NSUInteger)count;
@end