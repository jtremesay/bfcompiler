#import "BFToken.h"
#import "KLogging.h"


NSString * NSStringFromTokenType(BFTokenType tokenType)
{
    switch (tokenType) {
        case kBFTokenTypePtrDec:
            return @"kBFTokenTypePtrDec";

        case kBFTokenTypePtrInc:
            return @"kBFTokenTypePtrInc";

        case kBFTokenTypeByteDec:
            return @"kBFTokenTypeByteDec";

        case kBFTokenTypeByteInc:
            return @"kBFTokenTypeByteInc";

        case kBFTokenTypeLoopBegin:
            return @"kBFTokenTypeLoopBegin";

        case kBFTokenTypeLoopEnd:
            return @"kBFTokenTypeLoopEnd";

        case kBFTokenTypePut:
            return @"kBFTokenTypePut";

        case kBFTokenTypeGet:
            return @"kBFTokenTypeGet";


        case kBFTokenTypeInvalid:
        default:
            return @"kBFTokenTypeInvalid";
    }
}

@implementation BFToken
@synthesize tokenType = _tokenType;
@synthesize lexeme = _lexeme;
@synthesize line = _line;
@synthesize column = _column;

- (void)dealloc
{
    [_lexeme release];

    [super dealloc];
}

- (NSString *)prettyDescription
{
    return [NSString stringWithFormat:@"BFToken %@ (%@) at %u:%u", NSStringFromTokenType(self.tokenType), self.lexeme, self.line, self.column];
}
@end
