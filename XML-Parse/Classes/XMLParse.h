//
//  XMLParse.h
//  Pods
//
//  Created by Blake Shetter on 8/16/16.
//
//

#import <Foundation/Foundation.h>

@interface XMLParse : NSObject
-(id)initWithParseURL:(NSString *)urlToParse;
-(void)parse;
-(void)XMLParseDidFail;
-(void)XMLParseDidFinishSuccessfully:(NSArray *)xml;

@property (strong,nonatomic) NSString *parseURL;
@property (strong,nonatomic) id delegate;
@property BOOL search; // used to mark the start of the document search - default: NO
@property (nonatomic, strong) NSMutableString *foundValue;
@property (nonatomic, strong) NSString *currentElement;


@property (nonatomic, strong) NSMutableDictionary *dictTempDataStorage;
@property (nonatomic, strong) NSMutableArray *xmlArray;

@property BOOL hasAttrDict;
@property (strong,nonatomic) NSMutableDictionary *attributeDict;

//optional
@property (strong,nonatomic) NSString *startingTreeElement; // most start with item - this allows you to overwrite it - defult: item
@property BOOL cleanString; // a lot of XML feeds include \n & \t at the front and back of the string - this gives you the opion to remove that content - default: YES


@end
