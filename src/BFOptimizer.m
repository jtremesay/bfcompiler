#import "BFOptimizer.h"
#import "BFOptimizerSubclass.h"
#import "KLogging.h"
#import "BFAST.h"

@implementation BFOptimizer
- (void)optimizeProgram:(BFNodeProgram *)program
{
    BOOL done = NO;

    BFNodeGroup * currentNodeGroup = program;
    while (!done) {
        BOOL hasModifiedSomething = NO;


        if (!hasModifiedSomething) {
            currentNodeGroup = currentNodeGroup.parent;
            if (!currentNodeGroup) {
                done = YES;
            }
        }
    }
}
@end