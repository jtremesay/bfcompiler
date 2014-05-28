#import "BFAST.h"
#import "KLogging.h"
#import "BFToken.h"

static NSUInteger sIndentLevel = 0;
static NSString * generateIndent(NSUInteger level)
{
    NSMutableString * indent = [NSMutableString stringWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [indent appendString:@"\t"];
    }

    return indent;
}


@implementation BFNode
@synthesize token = _token;
@synthesize parent = _parent;

- (id)initWithToken:(BFToken *)token
{
    self = [super init];
    if (self) {
        self.token = token;
    }

    return self;
}

- (void)dealloc
{
    [_token release];

    [super dealloc];
}

- (NSString *)prettyDescription
{
    NSMutableString * description = [NSMutableString stringWithCapacity:4096];
    [description appendString:[self className]];
    /*
    [description appendString:@" ("];
    [description appendString:[[self token] prettyDescription]];
    [description appendString:@")"];
    //*/
    return description;
}
@end

@implementation BFNodeGroup
- (id)initWithToken:(BFToken *)token
{
    self = [super initWithToken:token];
    if (self) {
        _nodes = [[NSMutableArray alloc] initWithCapacity:0];
    }

    return self;
}

- (void)dealloc
{
    [_nodes release];

    [super dealloc];
}

- (void)addNode:(BFNode *)node
{
    node.parent = self;

    [_nodes addObject:node];
}

- (NSString *)prettyDescription
{
    NSMutableString * description = [NSMutableString stringWithCapacity:4096];
    [description appendString:[self className]];
    /*
    [description appendString:@" ("];
    [description appendString:[[self token] prettyDescription]];
    [description appendString:@")"];
    //*/
    [description appendString:@" [\n"];
    sIndentLevel++;
    for(BFNode * node in _nodes) {
        [description appendString:generateIndent(sIndentLevel)];
        [description appendString:[node prettyDescription]];
        [description appendString:@"\n"];
    }
    sIndentLevel--;
    [description appendString:generateIndent(sIndentLevel)];
    [description appendString:@"] ("];
    [description appendFormat:@"%d", _nodes.count];
    [description appendString:@" nodes)"];


    return description;
}
@end

@implementation BFNodeProgram
- (id)init
{
    self = [super initWithToken:nil];

    return self;
}
@end

@implementation BFNodeLoop
@end

@implementation BFNodePtrDec
@end

@implementation BFNodePtrInc
@end

@implementation BFNodeByteDec
@end

@implementation BFNodeByteInc
@end

@implementation BFNodePut
@end

@implementation BFNodeGet
@end