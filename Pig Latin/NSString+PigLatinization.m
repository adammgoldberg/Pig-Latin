//
//  NSString+PigLatinization.m
//  Pig Latin
//
//  Created by Adam Goldberg on 2015-10-02.
//  Copyright (c) 2015 Adam Goldberg. All rights reserved.
//

#import "NSString+PigLatinization.h"

@implementation NSString (PigLatinization)


-(NSArray*)tokenize:(NSString*)string {
    NSMutableArray *letters = [[NSMutableArray alloc] init];
    for (NSInteger x = 0; x<string.length; x++) {
        NSRange range = NSMakeRange(x, 1);
        NSString *result = [string substringWithRange:range];
        [letters addObject:result];
    } return letters;
}


-(BOOL)isVowel:(NSString*)letter {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"aeiouAEIOU"];
    BOOL value = [set characterIsMember:[letter characterAtIndex:0]];
    return value;
}


-(NSArray*)switcheroo:(NSArray*)item {
    NSMutableArray *consonants = [[NSMutableArray alloc] init];
    [consonants addObject:item[0]];
    
    for (NSInteger x=1; x<item.count; x++) {
        BOOL vowel = [self isVowel:item[x]];
        if (!vowel) {
            [consonants addObject:item[x]];
            continue;
        }
        break;
        
    }

   
    NSMutableArray *itemMutable = [item mutableCopy];
    
    [itemMutable removeObjectsInArray:consonants];
    
    return [itemMutable arrayByAddingObjectsFromArray:consonants];
    

}

-(NSString*)completedString:(NSArray*)new {
    NSMutableArray *hold = [NSMutableArray array];
    for (NSArray *array in new) {
        NSString *str = [array componentsJoinedByString:@""];
        str = [str stringByAppendingString:@"ay"];
        [hold addObject: str];
    }
    return [hold componentsJoinedByString:@" "];
}


-(NSString *)stringByPigLatinization {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    NSArray *words = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSMutableArray *pigWords = [[NSMutableArray alloc] init];
    for (NSString *individualWord in words) {
        [pigWords addObject:[self tokenize:individualWord]];
    }
    for (NSArray *item in pigWords) {
        BOOL value = [self isVowel:item[0]];
        if (value) {
            [results addObject:item];
            continue;
            
        }
        
        NSArray *switchedArray = [self switcheroo:item];
        [results addObject:switchedArray];
        
        
        
    }
    
    

    
    
    NSString *pigString = [self completedString:results];
    
    NSLog(@"%@", pigString);
    
    return pigString;

    
    
}

@end
