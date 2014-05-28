#import "KLogging.h"
#import "BFAST.h"
#import "BFLexer.h"
#import "BFOptimizer.h"
#import "BFParser.h"

int main(int argc, char * argv[])
{
    int statusCode = EXIT_SUCCESS;

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    if (argc == 1) {
        NSLog(@"Usage: a.out [file]");
        statusCode = EXIT_FAILURE;

        goto cleanup;
    }

    NSString * path = [NSString stringWithUTF8String:argv[1]];

    NSLog(@"Lexing...");
    BFLexer * lexer = [[BFLexer alloc] init];
    [lexer setSourceCodeWithContentsOfFile:path];
    [lexer lex];
    NSArray * tokens = [lexer tokens];
    dump_array(tokens);
    [lexer release];


    NSLog(@"Parsing...");
    BFParser * parser = [[BFParser alloc] init];
    [parser setTokens:tokens];
    BFNodeProgram * program = [parser parse];
    dump_object(program);
    [parser release];


    NSLog(@"Optimizing... (WIP)");
    BFOptimizer * optimizer = [[BFOptimizer alloc] init];
    [optimizer optimizeProgram:program];
    dump_object(program);
    [optimizer release];


    NSLog(@"Compiling... (todo)");

    NSLog(@"Done!");

cleanup:
    [pool drain];

    return statusCode;
}