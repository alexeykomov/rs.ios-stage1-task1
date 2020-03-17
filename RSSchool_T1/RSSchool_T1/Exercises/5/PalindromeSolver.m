#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    NSMutableString *resultPalindrome = [[NSMutableString alloc] initWithString:s];
    int changesLeft = [k intValue];

    int leftPosition = 0;
    int rightPosition = [resultPalindrome length] - 1;
    // First pass. Replace non-equals by 9s.
    while (leftPosition < rightPosition) {
        NSRange leftRange = NSMakeRange(leftPosition, 1);
        NSRange rightRange = NSMakeRange(rightPosition, 1);
        NSString *leftSubstring = [resultPalindrome substringWithRange:leftRange];
        NSString *rightSubstring = [resultPalindrome substringWithRange:rightRange];
        // First pass only. We replace siblings by greater value.
        if (![leftSubstring isEqualToString:rightSubstring]) {
            if ([leftSubstring compare:rightSubstring] == 1) {
                if (changesLeft <= 0) {
                    return [@(-1) stringValue];
                }
                [resultPalindrome replaceCharactersInRange:rightRange withString:leftSubstring];
                changesLeft -= 1;
            }
            if ([leftSubstring compare:rightSubstring] == -1) {
                if (changesLeft <= 0) {
                    return [@(-1) stringValue];
                }
                [resultPalindrome replaceCharactersInRange:leftRange withString:rightSubstring];
                changesLeft -= 1;
            }
        }
        leftPosition++;
        rightPosition--;

    }

    if (changesLeft < 0) {
        return @"-1";
    }

    // 2nd and more passes. We replace macthed by 9s.
    leftPosition = 0;
    rightPosition = [resultPalindrome length] - 1;
    while (leftPosition <= rightPosition) {
        if (changesLeft > 0 && leftPosition == rightPosition) {
            NSRange middleIndexRange = NSMakeRange([resultPalindrome length] / 2, 1);
            [resultPalindrome replaceCharactersInRange:middleIndexRange withString:@"9"];
        };

        NSRange leftRange = NSMakeRange(leftPosition, 1);
        NSRange rightRange = NSMakeRange(rightPosition, 1);
        NSString *leftSubstring = [resultPalindrome substringWithRange:leftRange];
        NSString *rightSubstring = [resultPalindrome substringWithRange:rightRange];
        NSString *leftSubstringInput = [s substringWithRange:leftRange];
        NSString *rightSubstringInput = [s substringWithRange:rightRange];
        if ([leftSubstring compare:@"9"] < 0) {
            if (changesLeft >= 2 &&
                // In original string, symbols were equal already.
                [leftSubstringInput isEqualToString:leftSubstringInput]) {
                [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
                [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
                changesLeft -= 2;
            } else if (changesLeft >= 1 &&
                       // We've already touched one of the symbols in the original
                       // string, that's why we only decrement one change.
                       (![leftSubstring isEqualToString:leftSubstringInput] ||
                        ![rightSubstring isEqualToString:rightSubstringInput])) {
                [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
                [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
                changesLeft -= 1;
            }
        }
        leftPosition++;
        rightPosition--;
    }
    return resultPalindrome;
}

@end
