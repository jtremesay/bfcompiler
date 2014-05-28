#import "BFLexerSubclass.h"

@implementation BFLexer (protected)
- (void)addCharToCurrentLexeme:(unichar)c
{
    // Enlarge lexeme buffer if needed
    if (_currentLexemePosition >= _currentLexemeLength - 1) {
        _currentLexemeLength *= 2;
        _currentLexeme = realloc(_currentLexeme, _currentLexemeLength);
    }

    _currentLexeme[_currentLexemePosition++] = c;
}


- (NSString *)popCurrentLexeme
{
    NSString * lexeme =  [NSString stringWithCharacters:_currentLexeme
                                                 length:_currentLexemePosition];
    _currentLexemePosition = 0;

    return lexeme;
}

- (void)shift:(NSUInteger)count
{
    while (count--) {
        _currentChar = _next1Char;
        if (_codePosition >= _codeLength) {
            _next1Char = -1;
            break;
        }

        _next1Char = _code[_codePosition++];
    }
}
@end