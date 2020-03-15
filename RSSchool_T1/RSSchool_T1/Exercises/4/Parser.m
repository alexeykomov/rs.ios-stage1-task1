#import "Parser.h"

@implementation Parser

NSInteger sortByStartIndex(NSDictionary* posA, NSDictionary* posB, void *context) {
    int v1 = [(NSNumber*) posA[@"startIndex"] intValue];
    int v2 = [(NSNumber*) posB[@"startIndex"] intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _stack = [[NSMutableDictionary alloc] init];
        opening = @[@"<", @"(", @"["];
        closing = @[@">", @")", @"]"];
        for (int counter = 0; counter < [opening count]; counter++) {
            _stack[opening[counter]] = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

// Complete the parseString function below.
- (NSArray <NSString*>*)parseString:(NSString*)string {
    NSMutableArray<NSDictionary*> *positions = [[NSMutableArray alloc] init];
    NSMutableArray *pairs = [[NSMutableArray alloc] init];
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (int counter = 0; counter < [string length]; counter++) {
        NSRange r = NSMakeRange(counter, 1);
        NSString *symbol = [string substringWithRange:r];
        NSLog(@"Symbol: %@", symbol);
        if ([opening containsObject:symbol]) {
            NSLog(@"Found opening symbol: %@", symbol);
            NSDictionary *pos = @{
                @"symbol": symbol,
                @"index": @(counter)
            };
            [self push:pos];
        }
        if ([closing containsObject:symbol] &&
                [self matchesLastOpen:symbol]) {
            NSLog(@"Found closing symbol: %@", symbol);
            NSDictionary *matchingOpeningPos = [self popFrom:symbol];
            NSLog(@"Index in map: %@", matchingOpeningPos[@"index"]);
            int startIndex = [(NSNumber *)matchingOpeningPos[@"index"] intValue];
            NSRange r = NSMakeRange(startIndex + 1, counter - startIndex - 1);
            NSString *substring = [string substringWithRange:r];
            NSLog(@"Substring: %@", substring);
            
            [pairs addObject:@{
                @"substring":substring,
                @"startIndex":@(startIndex)
            }];
        }
    }
    NSArray *pairsSorted = [pairs sortedArrayUsingFunction:sortByStartIndex context:NULL];
    for (int counter = 0; counter < [pairsSorted count]; counter++) {
        [res addObject:pairsSorted[counter][@"substring"]];
    }
    NSLog(@"Result: %@", res);
    return res;
}

- (void) push:(NSDictionary*) item {
    NSString *symbol = item[@"symbol"];
    [_stack[symbol] addObject:item];
}

- (NSDictionary *)popFrom:(NSString*) symbol  {
    int indexOfClosing = [closing indexOfObject:symbol];
    NSString *matchingOpen = opening[indexOfClosing];
    NSMutableArray *stack = _stack[matchingOpen];
    if ([stack count] > 0) {
        NSDictionary *lastElement = [stack lastObject];
        [stack removeLastObject];
        return lastElement;
    }
    return nil;
}

- (BOOL)matchesLastOpen:(NSString *) symbol {
    int indexOfClosing = [closing indexOfObject:symbol];
    NSString *matchingOpen = opening[indexOfClosing];
    NSMutableArray *stack = _stack[matchingOpen];
    if ([stack count] < 0) {
        return NO;
    }
    NSDictionary *last = [stack lastObject];
    return [last[@"symbol"] isEqualToString:matchingOpen];
}

@end


