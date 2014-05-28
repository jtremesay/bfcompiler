#import "BFParser.h"
#import "KLogging.h"
#import "BFAST.h"
#import "BFToken.h"

@implementation BFParser
@synthesize tokens = _tokens;

- (void)dealloc
{
    [_tokens release];

    [super dealloc];
}

- (BFNodeProgram *)parse
{

    BFNodeProgram * program = [[BFNodeProgram alloc] init];
    BFNodeGroup * currentNodeGroup = program;
    NSMutableArray * nodesLoops = [[NSMutableArray alloc] initWithCapacity:0];
    for (BFToken * token in _tokens) {
        if (token.tokenType == kBFTokenTypeLoopEnd) {
            if (nodesLoops.count == 0) {
                NSLog(@"error: unexpected ] at %u:%u", token.line, token.column);
                [program release];
                program = nil;

                break;
            }

            [nodesLoops removeLastObject];
            if (nodesLoops.count > 0) {
                currentNodeGroup = nodesLoops.lastObject;
            } else {
                currentNodeGroup = program;
            }
        }

        BFNode * node = nil;
        BOOL isLoop = NO;
        switch (token.tokenType) {
            case kBFTokenTypePtrDec:
                node = [[BFNodePtrDec alloc] initWithToken:token];
                break;

            case kBFTokenTypePtrInc:
                node = [[BFNodePtrInc alloc] initWithToken:token];
                break;

            case kBFTokenTypeByteDec:
                node = [[BFNodeByteDec alloc] initWithToken:token];
                break;

            case kBFTokenTypeByteInc:
                node = [[BFNodeByteInc alloc] initWithToken:token];
                break;

            case kBFTokenTypeLoopBegin:
                node = [[BFNodeLoop alloc] initWithToken:token];
                isLoop = YES;
                break;

            case kBFTokenTypePut:
                node = [[BFNodePut alloc] initWithToken:token];
                break;

            case kBFTokenTypeGet:
                node = [[BFNodeGet alloc] initWithToken:token];
                break;

            default:
                break;
        }

        if (node) {
            [currentNodeGroup addNode:node];

            if (isLoop) {
                [nodesLoops addObject:node];
                currentNodeGroup = (BFNodeGroup *) node;
            }

            [node release];
        }
    }

    if (program && nodesLoops.count > 0) {
        NSLog(@"error: unexpected end of file, ] expected");
        [program release];
        program = nil;

        return nil;
    }

    [nodesLoops release];

    return [program autorelease];
}

@end