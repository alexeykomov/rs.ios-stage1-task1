#import "T1Array.h"

@implementation T1Array

// Complete the following fuction
- (NSArray *)convertToHappy:(NSArray *)sadArray {
    NSMutableArray *input;
    input = [[NSMutableArray alloc] initWithArray:sadArray copyItems:YES];
    NSMutableArray *output;
    output = [[NSMutableArray alloc] init];
    while (true) {
        NSLog(@"Pass");
        for (int counter = 0; counter < [input count]; counter++) {
            if (counter == 0 || counter == ([input count] - 1)) {
                [output addObject: [input objectAtIndex:counter]];
                continue;
            }
            int leftIndex = counter - 1;
            int rightIndex = counter + 1;
            int leftNeighbor = leftIndex >= 0 ?
                [(NSNumber *)[input objectAtIndex: leftIndex] intValue] :
                0;
            int rightNeighbor = rightIndex < [sadArray count] ?
                [(NSNumber *)[input objectAtIndex: rightIndex] intValue] :
                0;
            int current = [(NSNumber *)[input objectAtIndex:counter] intValue];
            if ((leftNeighbor + rightNeighbor) > current) {
                [output addObject: [input objectAtIndex:counter]];
            }
        }
        if ([output count] == [input count]) {
            break;
        }
        input = [[NSMutableArray alloc] initWithArray:output copyItems:YES];
        [output removeAllObjects];
    }
    NSLog(@"Result array: %@", output);
    NSLog(@"Count of output: %d", [output count]);
    return output;
}

@end
