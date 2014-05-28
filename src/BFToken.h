#import <Foundation/Foundation.h>

typedef enum
{
    kBFTokenTypeInvalid = 0,
    kBFTokenTypePtrDec,
    kBFTokenTypePtrInc,
    kBFTokenTypeByteDec,
    kBFTokenTypeByteInc,
    kBFTokenTypeLoopBegin,
    kBFTokenTypeLoopEnd,
    kBFTokenTypePut,
    kBFTokenTypeGet
} BFTokenType;

NSString * NSStringFromTokenType(BFTokenType tokenType);


@interface BFToken : NSObject
{
    BFTokenType _tokenType;
    NSString * _lexeme;
    NSUInteger _line;
    NSUInteger _column;
}

- (void)dealloc;
- (NSString *)prettyDescription;

@property (assign) BFTokenType tokenType;
@property (copy) NSString * lexeme;
@property (assign) NSUInteger line;
@property (assign) NSUInteger column;

@end