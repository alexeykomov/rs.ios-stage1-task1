#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    NSMutableString *resultPalindrome = [[NSMutableString alloc] initWithString:s];
    int changesLeft = [k intValue];
    
    int leftPosition = 0;
    int rightPosition = [resultPalindrome length] - 1;
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
        
    // 2nd and more passes. We replace macthed by 9s.
    leftPosition = 0;
    rightPosition = [resultPalindrome length] - 1;
    while (leftPosition < rightPosition) {
        NSRange leftRange = NSMakeRange(leftPosition, 1);
        NSRange rightRange = NSMakeRange(rightPosition, 1);
        NSString *leftSubstring = [resultPalindrome substringWithRange:leftRange];
        NSString *rightSubstring = [resultPalindrome substringWithRange:rightRange];
        if ([leftSubstring isEqualToString:rightSubstring] &&
                changesLeft >= 1) {
            [resultPalindrome replaceCharactersInRange:leftRange withString:@"9"];
            [resultPalindrome replaceCharactersInRange:rightRange withString:@"9"];
            changesLeft -= 1;
        }
        leftPosition++;
        rightPosition--;
        
    }
    if (changesLeft > 0 && ([resultPalindrome length] % 2 == 1)) {
        NSRange middleIndexRange = NSMakeRange([resultPalindrome length] / 2, 1);
        [resultPalindrome replaceCharactersInRange:middleIndexRange withString:@"9"];
    };
    
    return resultPalindrome;
}

@end
