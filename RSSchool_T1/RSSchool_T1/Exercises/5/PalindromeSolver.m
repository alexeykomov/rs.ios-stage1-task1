#import "PalindromeSolver.h"

@implementation PalindromeSolver

int countDiff(NSString *input) {
    int length = [input length];
    int diff = 0;
    for (int counter = 0; counter < length / 2; counter++) {
        NSRange leftRange = NSMakeRange(counter, 1);
        NSRange rightRange = NSMakeRange(length - (1 + counter), 1);
        if (![[input substringWithRange:leftRange] isEqualToString:
              [input substringWithRange:rightRange]]) {
            diff++;
        }
    }
    return diff;
}

BOOL isPalindrome(NSString *input) {
    int diff = countDiff(input);
    return diff == 0 ? YES : NO;
}

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    NSMutableString *resultPalindrome = [[NSMutableString alloc] initWithString:s];
    int changesLeft = [k intValue];
    int length = [resultPalindrome length];
    int diff = countDiff(resultPalindrome);
    
    if (diff > changesLeft) {
        return @"-1";
    }
    
    int leftPosition = 0;
    int rightPosition = [resultPalindrome length] - 1;
    while (leftPosition <= rightPosition) {
        if (changesLeft <= 0) {
            break;
        }
        
        NSRange leftRange = NSMakeRange(leftPosition, 1);
        NSRange rightRange = NSMakeRange(rightPosition, 1);
        NSString *leftSubstring = [resultPalindrome substringWithRange:leftRange];
        NSString *rightSubstring = [resultPalindrome substringWithRange:rightRange];
        if ([leftSubstring isEqualToString:rightSubstring]) {
            if (changesLeft > 1 && (changesLeft - 2) >= diff &&
                ![leftSubstring isEqualToString:@"9"]) {
                [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
                [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
                changesLeft -= 2;
            }
        } else {
            if (changesLeft > 1 && (changesLeft - 2) >= diff - 1) {
                if (![leftSubstring isEqualToString:@"9"]) {
                    [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
                    changesLeft--;
                }
                if (![rightSubstring isEqualToString:@"9"]) {
                    [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
                    changesLeft--;
                }
            } else {
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
            diff--;
        }
        if (leftPosition == rightPosition && changesLeft > 0) {
            [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
        }
        leftPosition++;
        rightPosition--;
    }
    
    return isPalindrome(resultPalindrome) ? resultPalindrome : @"-1";
}

@end
