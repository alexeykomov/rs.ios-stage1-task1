#import <Foundation/Foundation.h>

@interface Parser : NSObject
{
    NSMutableDictionary *_stack;
    NSArray *opening;
    NSArray *closing;
}

- (NSArray <NSString*>*)parseString: (NSString*)string;

@end

