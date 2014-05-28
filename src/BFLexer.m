#import "BFLexer.h"
#import "BFLexerSubclass.h"
#import "KLogging.h"
#import "BFToken.h"

@implementation BFLexer

- (id)init
{
    self = [super init];
    if (self) {
        _tokens = [[NSMutableArray alloc] initWithCapacity:0];

        _currentLexemeLength = 128;
        _currentLexeme = malloc(_currentLexemeLength * sizeof(unichar));
    }

    return self;
}

- (void)dealloc
{
    if (_code) {
        free(_code);
    }

    if (_currentLexeme) {
        free(_currentLexeme);
    }

    [_tokens release];

    [super dealloc];
}

- (void)setSourceCodeWithContentsOfFile:(NSString *)path
{
    NSError * error = nil;
    NSString * contentsOfFile = [NSString stringWithContentsOfFile:path
                                                          encoding:NSUTF8StringEncoding
                                                             error:&error];

    [self setSourceCodeWithString:contentsOfFile];
}

- (void)setSourceCodeWithString:(NSString *)string
{
    if (_code) {
        free(_code);
    }

    _codeLength = [string length];
    _code = malloc(_codeLength * sizeof(unichar));
    [string getCharacters:_code
                    range:NSMakeRange(0, _codeLength)];
}

- (void)lex
{
    [_tokens removeAllObjects];

    _codePosition = 0;
    _currentLexemePosition = 0;
    _currentLine = 1;
    _currentColumn = 1;
    _currentChar = 0;
    _next1Char = 0;
    _done = NO;


    [self shift:2];
    while (!_done) {
        if (_currentChar == '\r') {
            if (_next1Char == '\n') {
                [self shift:1];
            }

            _currentLine++;
            _currentColumn = 0;
        } else if (_currentChar == '\n') {
            if (_next1Char == '\r') {
                [self shift:1];
            }

            _currentLine++;
            _currentColumn = 0;
        } else {
            BFTokenType tokenType = kBFTokenTypeInvalid;
            switch (_currentChar) {
                case '<':
                    tokenType = kBFTokenTypePtrDec;
                    break;

                case '>':
                    tokenType = kBFTokenTypePtrInc;
                    break;

                case '-':
                    tokenType = kBFTokenTypeByteDec;
                    break;

                case '+':
                    tokenType = kBFTokenTypeByteInc;
                    break;

                case '[':
                    tokenType = kBFTokenTypeLoopBegin;
                    break;

                case ']':
                    tokenType = kBFTokenTypeLoopEnd;
                    break;

                case '.':
                    tokenType = kBFTokenTypePut;
                    break;

                case ',':
                    tokenType = kBFTokenTypeGet;
                    break;
            }

            if (tokenType != kBFTokenTypeInvalid) {
                [self addCharToCurrentLexeme:_currentChar];

                BFToken * token = [[BFToken alloc] init];
                token.tokenType = tokenType;
                token.line = _currentLine;
                token.column = _currentColumn;
                token.lexeme = [self popCurrentLexeme];
                [_tokens addObject:token];
                [token release];
            }
        }


        [self shift:1];
        _currentColumn++;
        if (_currentChar == (unichar) -1) {
            _done = YES;
        }
    }
}

- (NSArray *)tokens
{
    return [[_tokens copy] autorelease];
}
@end