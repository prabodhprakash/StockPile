//
//  LRUCache.m
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import "LRUCache.h"
#import "LinkedHashMap.h"
#import "CachingException.h"

@interface LRUCache()

@property (nonatomic, strong) LinkedHashMap* linkedHashMap;
@property (nonatomic, assign) int capacity;
@property (nonatomic, assign) int currentSize;
@property (nonatomic, assign) int hitCount;
@property (nonatomic, assign) int missCount;

@end

@implementation LRUCache

- (instancetype) initWithCapacity: (int) capacity
{
    if (capacity <= 0)
    {
        @throw [[CachingException alloc] initWithReason:@"Capacity must be greater than 0"];
    }
    
    self = [super init];
    
    if (self)
    {
        _capacity = capacity;
        _linkedHashMap = [[LinkedHashMap alloc] initWithCapacity:capacity];
    }
    
    return self;
}

- (void) cacheNode: (Node*) node
{
    if (_currentSize == _capacity)
    {
        [_linkedHashMap removeEndNode];
        _currentSize--;
    }
    
    [_linkedHashMap putNode:node];
    _currentSize++;
}

- (Node*) getNodeForKey:(NSString*) key
{
    Node* node = [_linkedHashMap getObject:key];
    
    if (node != nil)
    {
        _hitCount++;
        
        [_linkedHashMap moveNode:node toPosition:0];
    }
    else
    {
        _missCount++;
    }
    
    return node;
}

- (void) clearCache
{
    _currentSize = 0;
    [_linkedHashMap clear];
}

@end
