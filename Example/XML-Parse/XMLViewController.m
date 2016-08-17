//
//  XMLViewController.m
//  XML-Parse
//
//  Created by Blake on 08/16/2016.
//  Copyright (c) 2016 Blake. All rights reserved.
//

#import "XMLViewController.h"

#import <XMLParse.h>
@interface XMLViewController ()

@end

@implementation XMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //XMLParse *parse=[[XMLParse alloc] initWithParseURL:@"http://www.newsisfree.com/HPE/xml/feeds/42/1842.xml"];
    XMLParse *parse=[[XMLParse alloc] initWithParseURL:@"http://www.tattoonow.com/rss/tattoo-of-the-day.xml"];
    parse.delegate=(id)self;
    [parse parse];
    
}

-(void)XMLParseDidFinishSuccessfully:(NSArray *)xml{
    NSLog(@"Success");
    NSLog(@"%@",xml);
}
-(void)XMLParseDidFail{
    #warning - handle failed XML parse here
    NSLog(@"Failed VC Parse");
}

@end
