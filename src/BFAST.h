#import <Foundation/Foundation.h>

@class BFToken;
@class BFNodeGroup;

@interface BFNode : NSObject
{
    BFToken * _token;
    BFNodeGroup * _parent;
}

- (id)initWithToken:(BFToken *)token;
- (void)dealloc;
- (NSString *)prettyDescription;

@property (retain) BFToken * token;
@property (assign) BFNodeGroup * parent;
@end

@interface BFNodeGroup : BFNode
{
    NSMutableArray * _nodes;
}

- (id)initWithToken:(BFToken *)token;
- (void)dealloc;
- (void)addNode:(BFNode *)node;
- (NSString *)prettyDescription;
@end

@interface BFNodeProgram : BFNodeGroup
{
}
- (id)init;
@end

@interface BFNodeLoop : BFNodeGroup
{
}
@end

@interface BFNodePtrDec : BFNode
{
}
@end

@interface BFNodePtrInc : BFNode
{
}
@end

@interface BFNodeByteDec : BFNode
{
}
@end

@interface BFNodeByteInc : BFNode
{
}
@end

@interface BFNodePut : BFNode
{
}
@end

@interface BFNodeGet : BFNode
{
}
@end