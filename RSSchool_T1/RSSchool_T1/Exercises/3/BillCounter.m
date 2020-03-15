#import "BillCounter.h"

@implementation BillCounter

// Complete the following fuction
- (NSString*)compareResultForBill:(NSArray<NSNumber*>*)bill notIncludingElementWithIndex:(NSInteger)index withGivenSum:(NSNumber*)sum {
    int givenSum = [(NSNumber*) sum intValue];
    int actualSum = 0;
    for (int counter = 0; counter < [bill count]; counter++) {
        if (counter == index) {
            continue;
        }
        actualSum += [(NSNumber*) bill[counter] intValue];
    };
    actualSum /= 2;
    if (actualSum == givenSum) {
        return @"Bon Appetit";
    }
    return [@(givenSum - actualSum) stringValue];
}

@end
