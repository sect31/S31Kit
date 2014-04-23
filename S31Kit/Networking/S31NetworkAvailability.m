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
            result = @"ReachableViaWWAN";
            return  result;
            NSLog(@"Current Cell Type: %@", [self currentCellNetworkType]);
            break;
        }

    }
    return 0;
}

+ (NSString *)currentCellNetworkType
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    return telephonyInfo.currentRadioAccessTechnology;
}




@end
