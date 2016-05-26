

#import "NSObject+NSKeyValueOption.h"
#import <objc/message.h>

@implementation NSObject(NSObjectCopyKeyValue) 
 

+ (void) copyObject:(NSObject<NSObjectCopyKeyValue> *) src toObject:(NSObject<NSObjectCopyKeyValue> *) dest{
    [NSObject copyObject:src toObject:dest transients:nil];
}

+ (void) copyObject:(NSObject<NSObjectCopyKeyValue> *) src toObject:(NSObject<NSObjectCopyKeyValue> *) dest transients:(NSArray *) transients
{
    
    if(![src isKindOfClass:[dest class]]){
        NSException *e = [[NSException alloc] initWithName:@"对象类型不一致!" reason:nil userInfo:nil];
        @throw e;
    }else{
        [NSObject copyAnyObject:src toAnyObject:dest transients:transients];
    }
    
}
+ (void) copyAnyObject:(NSObject<NSObjectCopyKeyValue> *) src toAnyObject:(NSObject<NSObjectCopyKeyValue> *) dest{
    [NSObject copyAnyObject:src toAnyObject:dest transients:nil];
}

+ (void) copyAnyObject:(NSObject<NSObjectCopyKeyValue> *) src toAnyObject:(NSObject<NSObjectCopyKeyValue> *) dest transients:(NSArray *) transients
{
    if(![src conformsToProtocol:@protocol(NSObjectCopyKeyValue)]){
        NSException *e = [[NSException alloc] initWithName:@"对象未实现协议 NSObjectCopyKeyValue!" reason:nil userInfo:nil];
        @throw e;
    }
    if(![dest conformsToProtocol:@protocol(NSObjectCopyKeyValue)]){
        NSException *e = [[NSException alloc] initWithName:@"对象未实现协议 NSObjectCopyKeyValue!" reason:nil userInfo:nil];
        @throw e;
    }
    
    NSMutableDictionary *_properties = [NSMutableDictionary dictionaryWithCapacity:0];
    [NSObject propertyMap:_properties clazz:[src class]];
    
    for (NSString *key in _properties) {
        NSString *pType = [_properties objectForKey:key];
        
        @synchronized(src) {
            NSString *method=[NSString stringWithFormat:@"set%@%@:", [[key substringToIndex:1] uppercaseString], [key substringFromIndex:1]];
            
            BOOL isTransients = NO;
            if (transients) {
                NSPredicate *pTransients = [NSPredicate predicateWithFormat:@"SELF=%@", key];
                NSArray *results = [transients filteredArrayUsingPredicate:pTransients];
                isTransients = (results.count != 0);
            }
            
            if(![src respondsToSelector:NSSelectorFromString(key)] || ![dest respondsToSelector:NSSelectorFromString(method)] || isTransients) continue;
            
            
            
            if ([pType hasPrefix:@"T@"]) {
                id value = ((id(*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSMutableString class]] ||
                    [value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]] ||
                    [value isKindOfClass:[NSData class]] || [value isKindOfClass:[NSMutableData class]] ||
                    [value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSMutableDictionary class]] ||
                    [value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSNull class]])
                {
                    ((void(*)(id, SEL, id))objc_msgSend)(dest, NSSelectorFromString(method), value);
                }
                else if (!value) continue;
                else
                {
                    if ([pType hasPrefix:@"T@?,C,"]) {
                        continue;
                    }
                    if ([pType hasPrefix:@"T@,W,"]) {
                        continue;
                    }
                    id destValue = ((id(*)(id, SEL))objc_msgSend)(dest, NSSelectorFromString(key));
                    [NSObject copyAnyObject:value toAnyObject:destValue transients:transients];
                }
                
            }
            else if([pType hasPrefix:@"T{"])
            {
            }
            else
            {
                pType = [pType lowercaseString];
                if ([pType hasPrefix:@"ti"] || [pType hasPrefix:@"tb"])
                {
                    int destValue = ((int (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, int))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
                else if ([pType hasPrefix:@"tf"])
                {
                    float destValue = ((float (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, float))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
                else if([pType hasPrefix:@"td"])
                {
                    double destValue = ((double (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, double))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
                else if([pType hasPrefix:@"tl"] || [pType hasPrefix:@"tq"])
                {
                    long long destValue = ((long long (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, long long))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
                else if ([pType hasPrefix:@"tc"])
                {
                    char destValue = ((char (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, char))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
                else if([pType hasPrefix:@"ts"])
                {
                    short destValue = ((short (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                    ((void(*)(id, SEL, short))objc_msgSend)(dest, NSSelectorFromString(method), destValue);
                }
            }
        }
    }

}
- (void) setValuesKeysToObject:(NSObject<NSObjectCopyKeyValue> *) dest{
    [NSObject copyAnyObject:(NSObject<NSObjectCopyKeyValue> *)self toAnyObject:dest transients:nil];
}
- (void) setValuesKeysToObject:(NSObject<NSObjectCopyKeyValue> *) dest transients:(NSArray *) transients{
    [NSObject copyAnyObject:(NSObject<NSObjectCopyKeyValue> *)self toAnyObject:dest transients:nil];
}

+ (void) copyDictionary:(NSDictionary *) src toObject:(NSObject<NSObjectCopyKeyValue> *) dest{
    [NSObject copyDictionary:src toObject:dest transients:nil];
}

+ (void) copyDictionary:(NSDictionary *)src toObject:(NSObject<NSObjectCopyKeyValue> *) dest transients:(NSArray *) transients
{
    NSMutableDictionary *keyValues =[[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *_properties = [NSMutableDictionary dictionaryWithCapacity:0];
    [NSObject propertyMap:_properties clazz:[dest class]];
    
    for (NSString *key in _properties) {
        NSString *pType = [_properties objectForKey:key];
        
        if ([pType hasPrefix:@"T@"]) {
            id value = ((id(*)(id, SEL))objc_msgSend)(dest, NSSelectorFromString(key));
            if([value conformsToProtocol:@protocol(NSObjectCopyKeyValue)]){
                id dicValue = [src objectForKey:key];
                [NSObject copyDictionary:dicValue toObject:value transients:transients];
                continue;
            }
        } 
        
        if([src objectForKey:key]){
            [keyValues setObject:[src objectForKey:key] forKey:key];
        }
        
    }
    
    [keyValues removeObjectsForKeys:transients];
    
    [dest setValuesForKeysWithDictionary:keyValues];
    
}
- (void) setValuesForKeysFromDictionary:(NSDictionary *) src{
    [self setValuesForKeysFromDictionary:src transients:nil];
}
- (void) setValuesForKeysFromDictionary:(NSDictionary *) src transients:(NSArray *) transients{
    NSMutableDictionary *keyValues =[[NSMutableDictionary alloc] initWithDictionary:src];
    
    NSMutableDictionary *_properties = [NSMutableDictionary dictionaryWithCapacity:0];
    [NSObject propertyMap:_properties clazz:[self class]];
    
    for (NSString *key in _properties) {
        NSString *pType = [_properties objectForKey:key];
        
        if ([pType hasPrefix:@"T@"]) {
            id value = ((id(*)(id, SEL))objc_msgSend)(self, NSSelectorFromString(key));
            if([value conformsToProtocol:@protocol(NSObjectCopyKeyValue)]){
                id dicValue = [src objectForKey:key];
                [NSObject copyDictionary:dicValue toObject:value transients:transients];
                continue;
            }
        }
        
        if([src objectForKey:key]){
            [keyValues setObject:[src objectForKey:key] forKey:key];
        }
        
    }
    
    [keyValues removeObjectsForKeys:transients];
    
    [self setValuesForKeysWithDictionary:keyValues];
    
    
#if DEBUG
    
    
#endif

}

+ (void)propertyMap:(NSMutableDictionary *)dic clazz:(Class)clazz{
    BOOL validate = [clazz conformsToProtocol:@protocol(NSObjectCopyKeyValue)];
    
    if(!validate){
        return;
    }else{
        
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
        for(int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSASCIIStringEncoding];
            NSString *pType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [dic setObject:pType forKey:key];
        }
        
        free(properties);
        
        [NSObject propertyMap:dic clazz:[clazz superclass]];
    }

}


+ (NSDictionary<NSString *, id> *)dictionaryKeysValues:(NSObject<NSObjectCopyKeyValue> *) src{
    return [NSObject dictionaryKeysValues:src transients:nil];
}
+ (NSDictionary<NSString *, id> *)dictionaryKeysValues:(NSObject<NSObjectCopyKeyValue> *) src transients:(NSArray *) transients{
    
    NSMutableDictionary *_properties = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [NSObject propertyMap:_properties clazz:[src class]];
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *key in _properties) {
        NSString *pType = [_properties objectForKey:key];
        
        BOOL isTransients = NO;
        if (transients) {
            NSPredicate *pTransients = [NSPredicate predicateWithFormat:@"SELF=%@", key];
            NSArray *results = [transients filteredArrayUsingPredicate:pTransients];
            isTransients = (results.count != 0);
        }
        
        if(![src respondsToSelector:NSSelectorFromString(key)] || isTransients) continue;
        
        NSString *keyValue = nil;
        if ([key isEqualToString:@"_Id"]) keyValue = @"id"; else keyValue = key;
        
        if ([pType hasPrefix:@"T@"]) {
            id value = ((id(*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
            if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSMutableString class]] ||
                [value isKindOfClass:[NSData class]] || [value isKindOfClass:[NSMutableData class]] ||
                [value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]] ||
                [value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSMutableDictionary class]] ||
                [value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSNull class]])
            {
                [result setObject:value forKey:keyValue];
            }else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]])
            {
                NSMutableArray *mTmp = value;
                if (mTmp.count > 0) {
                    if ([[mTmp firstObject] isKindOfClass:[NSString class]] || [[mTmp firstObject] isKindOfClass:[NSMutableString class]] ||
                        [[mTmp firstObject] isKindOfClass:[NSData class]] || [[mTmp firstObject] isKindOfClass:[NSMutableData class]] ||
                        [value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSMutableDictionary class]] ||
                        [[mTmp firstObject] isKindOfClass:[NSNumber class]] || [[mTmp firstObject] isKindOfClass:[NSNull class]]) {
                        [result setObject:value forKey:keyValue];
                    }else {
                        NSMutableArray *m_Tmp = [NSMutableArray arrayWithCapacity:0];
                        for (id tmpObjc in value){
                            [m_Tmp addObject:[NSObject dictionaryKeysValues:tmpObjc transients:transients]];
                        }
                        [result setObject:m_Tmp forKey:keyValue];
                    }
                }else
                {
                    [result setObject:value forKey:keyValue];
                }
            }
            
            else if (!value) continue;
            else{
                if ([pType hasPrefix:@"T@?,C,"]) {
                    continue;
                }
                if ([pType hasPrefix:@"T@,W,"]) {
                    continue;
                }
                [result setObject:[NSObject dictionaryKeysValues:value transients:transients] forKey:key];
            }
        }
        else if([pType hasPrefix:@"T{"]) {}
        else
        {
            pType = [pType lowercaseString];
            if ([pType hasPrefix:@"ti"] || [pType hasPrefix:@"tb"])
            {
                int value = ((int (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithInt:value] forKey:keyValue];
            }
            else if ([pType hasPrefix:@"tf"])
            {
                float value = ((float (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithFloat:value] forKey:keyValue];
            }
            else if([pType hasPrefix:@"td"])
            {
                double value = ((double (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithDouble:value] forKey:keyValue];
            }
            else if([pType hasPrefix:@"tl"] || [pType hasPrefix:@"tq"])
            {
                long long value = ((long long (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithLongLong:value] forKey:keyValue];
            }
            else if ([pType hasPrefix:@"tc"])
            {
                char value = ((char (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithChar:value] forKey:keyValue];
            }
            else if([pType hasPrefix:@"ts"])
            {
                short value = ((short (*)(id, SEL))objc_msgSend)(src, NSSelectorFromString(key));
                [result setObject:[NSNumber numberWithShort:value] forKey:keyValue];
            }
        }
    } 
    return result;
}

- (NSDictionary<NSString *, id> *)dictionaryKeysValues{
    return [NSObject dictionaryKeysValues:(NSObject<NSObjectCopyKeyValue> *)self transients:nil];
}
- (NSDictionary<NSString *, id> *)dictionaryKeysValuesWithTransients:(NSArray *) transients{
    return [NSObject dictionaryKeysValues:(NSObject<NSObjectCopyKeyValue> *)self transients:nil];
}

@end

@implementation NSDictionary(NSDictionaryKeyValueCopy)

- (void) setValuesForKeysToObject:(NSObject<NSObjectCopyKeyValue> *) dest{
    [NSObject copyDictionary:self toObject:dest transients:nil];
}
- (void) setValuesForKeysToObject:(NSObject<NSObjectCopyKeyValue> *) dest transients:(NSArray *) transients{
    [NSObject copyDictionary:self toObject:dest transients:transients];
}

@end


@implementation NSDictionary(NSDictionaryGetValue)


- (NSString *)stringForKey:(id)aKey{
    NSObject *obj  =  [self objectForKey:aKey];
    if([obj isKindOfClass:[NSString class]])
        return (NSString *)obj;
    else
        return nil;
}
- (NSNumber *)numberForKey:(id)aKey{
    NSObject *obj  =  [self objectForKey:aKey];
    if([obj isKindOfClass:[NSNumber class]])
        return (NSNumber *)obj;
    else
        return nil;
}

- (NSArray *)arrayForKey:(id)aKey{
    NSObject *obj  =  [self objectForKey:aKey];
    if([obj isKindOfClass:[NSArray class]])
        return (NSArray *)obj;
    else
        return nil;
}
- (NSDictionary *)dictionaryForKey:(id)aKey{
    NSObject *obj  =  [self objectForKey:aKey];
    if([obj isKindOfClass:[NSDictionary class]])
        return (NSDictionary *)obj;
    else
        return nil;
}

@end

@implementation NSDate(NSDateLongLongValue)

- (long long)longLongValue{
    return (long long)(self.timeIntervalSince1970 *1000.0);
}
+ (instancetype)dateWithTimeIntervalLongLongValue:(long long)longLongValue{
    return [NSDate dateWithTimeIntervalSince1970:(longLongValue *1.0)/1000.0];
}

@end