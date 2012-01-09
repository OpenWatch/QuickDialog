//
//  Created by escoz on 1/7/12.
//
#import "JsonDataSampleController.h"
#import <objc/runtime.h>

@implementation JsonDataSampleController

-(void)handleReloadJson:(QElement *)button {
    self.root = [[QRootElement alloc] initWithJSONFile:@"jsondatasample"];
}

-(void)handleLoadJsonWithDict:(QElement *)button {
    NSMutableDictionary *dataDict = [NSMutableDictionary new];
    [dataDict setValue:@"Yesterday" forKey:@"myDate"];
    [dataDict setValue:@"Midnight" forKey:@"myTime"];
    [dataDict setValue:@"When?" forKey:@"dateTitle"];
    [dataDict setValue:@"What time?" forKey:@"timeTitle"];
    [dataDict setValue:[NSNumber numberWithBool:YES] forKey:@"bool"];
    [dataDict setValue:[NSNumber numberWithFloat:0.4] forKey:@"float"];

    self.root = [[QRootElement alloc] initWithJSONFile:@"jsondatasample" andData:dataDict];
}

- (void)handleBindToObject:(QElement *)button {
    NSMutableDictionary *dataDict = [NSMutableDictionary new];
    [dataDict setValue:@"Obj Date" forKey:@"myDate"];
    [dataDict setValue:@"Obj Time" forKey:@"myTime"];
    [dataDict setValue:@"Hello" forKey:@"dateTitle"];
    [dataDict setValue:@"Goodbye" forKey:@"timeTitle"];
    [dataDict setValue:@"Bound from object" forKey:@"sectionTitle"];
    [dataDict setValue:[NSNumber numberWithBool:NO] forKey:@"bool"];
    [dataDict setValue:[NSNumber numberWithFloat:0.9] forKey:@"float"];
    [self.root bindToObject:dataDict];
    [self.quickDialogTableView reloadData];
}

-(void)handleSetValuesDirectly:(QElement *)button {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    QLabelElement *elDate = (QLabelElement *) [[self root] elementWithKey:@"date"];
    elDate.value = [dateFormatter stringFromDate:[NSDate date]];

    [dateFormatter setDateFormat:@"HH-mm-ss"];
    QLabelElement *elTime = (QLabelElement *) [[self root] elementWithKey:@"time"];
    elTime.value = [dateFormatter stringFromDate:[NSDate date]];

    [self.quickDialogTableView reloadCellForElements:elDate, elTime, nil];
}

-(void)handleBindWithJsonData:(QElement *)button {
    NSString *json = @"{ \"items\" : [{\"row\":\"row1\"},{\"row\":\"row2\"},{\"row\":\"row3\"}]}";
    Class JSONSerialization = objc_getClass("NSJSONSerialization");
    NSAssert(JSONSerialization != NULL, @"No JSON serializer available!");
    NSError *jsonParsingError = nil;
    NSDictionary *data = [JSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonParsingError ];
    [self.root bindToObject:data];

    [self.quickDialogTableView reloadData];
}

@end