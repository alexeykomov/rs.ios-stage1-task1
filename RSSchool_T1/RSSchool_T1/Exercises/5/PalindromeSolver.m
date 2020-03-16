#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    NSMutableString *resultPalindrome = [[NSMutableString alloc] initWithString:s];
    int changesLeft = [k intValue];
    int passCounter = 0;
    while (changesLeft > 0) {
        int leftPosition = 0;
        int rightPosition = [resultPalindrome length] - 1;
        
        while (leftPosition != rightPosition) {
            NSRange leftRange = NSMakeRange(leftPosition, 1);
            NSRange rightRange = NSMakeRange(rightPosition, 1);
            NSString *leftSubstring = [resultPalindrome substringWithRange:leftRange];
            NSString *rightSubstring = [resultPalindrome substringWithRange:rightRange];
            // First pass only. We replace siblings by greater value.
            if (![leftSubstring isEqualToString:rightSubstring] &&                  passCounter == 0) {
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
            // 2nd and more passes. We replace macthed by 9s.
            if ([leftSubstring isEqualToString:rightSubstring] && passCounter > 0 && changesLeft >= 2) {
                [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
                [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
                changesLeft -= 2;
            }
            leftPosition++;
            rightPosition++;
            passCounter++;
        }
        if (changesLeft > 0 && ([resultPalindrome length] % 2 == 1)) {
            NSRange middleIndexRange = NSMakeRange([resultPalindrome length] / 2, 1);
            [resultPalindrome replaceCharactersInRange:middleIndexRange withString:@"9"];
        }
    }
    
    return resultPalindrome;
}

@end
