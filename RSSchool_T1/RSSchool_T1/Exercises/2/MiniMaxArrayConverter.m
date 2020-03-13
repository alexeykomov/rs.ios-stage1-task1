#import "MiniMaxArrayConverter.h"
#import "limits.h"

@implementation MiniMaxArrayConverter

// Complete the convertFromArray function below.
- (NSArray<NSNumber*>*)convertFromArray:(NSArray<NSNumber*>*)array {
    int minSum = INT_MAX;
    int maxSum = INT_MIN;
    for (int counterA = 0; counterA < [array count]; counterA++) {
        int indexToSkip = counterA;
        int sum = 0;
        for (int counterB = 0; counterB < [array count]; counterB++) {
            if (counterB == indexToSkip) {
                continue;
            }
            sum += [(NSNumber *)[array objectAtIndex:counterB] intValue];
        }
        NSLog(@"Sum: %d", sum);
        if (sum > maxSum) {
            maxSum = sum;
        }
        if (sum < minSum) {
            minSum = sum;
        }
    }
    return @[@(minSum), @(maxSum)];
}

@end
