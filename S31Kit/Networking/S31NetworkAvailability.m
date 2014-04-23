//
//  S31NetworkAvailability.m
//  S31Kit
//
//  Created by Section 31 on 05/04/2014.
//  Copyright (c) 2014 Section 31 Pte. Ltd. All rights reserved.
//

#import "S31NetworkAvailability.h"
@import SystemConfiguration;
@import CoreTelephony;
#import "Reachability.h"
#include <netinet/in.h>

typedef enum : NSInteger {
	GPRS_EDGE = 0,
	THREE_G,
	FOUR_G
} CellTechType;

@implementation S31NetworkAvailability

+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
	
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags\n");
        return 0;
    }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSString *)currentNetworkTypeFromReachability
{
    NSString *result = nil;
    Reachability *reachable = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reachable currentReachabilityStatus];
    BOOL connectionRequired = [reachable connectionRequired];
    
    switch (netStatus) {
        case NotReachable:        {
            result = @"Not Reachable";
            return  result;
             //Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWiFi:        {
            result = @"ReachableViaWiFi";
            return  result;
            break;
        }
            
        case ReachableViaWWAN:        {
            NSLog(@"Current Cell Type: %@", [self currentCellNetworkType]); // Type of WWAN connection
            result = @"ReachableViaWWAN";
            return  result;
            break;
        }

    }
    return 0;
}

+ (NSString *)currentCellNetworkType
{
    NSString *result = nil;
    
    if ([self currentCellTechnology] == 0) {
        result = @"GPRS";
    }
    
    if ([self currentCellTechnology] == 1) {
        result = @"3G";
    }
    
    if ([self currentCellTechnology] == 2) {
        result = @"4G";
    }
    
    return result;
}

+ (CellTechType)currentCellTechnology
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    
    if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        return GPRS_EDGE;
    }
    
    if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
        return THREE_G;
    }
    
    if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE] ||
        [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        return FOUR_G;
    }
    
    return 0;
}


@end
