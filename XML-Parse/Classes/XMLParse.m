//
//  XMLParse.m
//  Pods
//
//  Created by Blake Shetter on 8/16/16.
//
//

#import "XMLParse.h"

@implementation XMLParse
-(id)initWithParseURL:(NSString *)urlToParse{
    self = [super init];
    if(self)
    {
        _xmlArray=[[NSMutableArray alloc] init];
        _attributeDict = [[NSMutableDictionary alloc] init];
        _foundValue=[NSMutableString stringWithString:@""];
        _parseURL=urlToParse;
        _cleanString=YES;
        _search=NO;
        _startingTreeElement=@"item";
    }
    return self;
}

-(void)parse{
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:self.parseURL]];
    [parser setDelegate:(id)self];
    [parser setShouldResolveExternalEntities:NO];
    
    
    if([parser parse]){
        [self.delegate XMLParseDidFinishSuccessfully:self.xmlArray];
    }
    else{
        [self.delegate XMLParseDidFail];
    }
}




- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"parse done");
}
-(NSString *)cleanString:(NSString *)string{
    if(!self.cleanString){return string;}
    NSString *string1 = [string stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *string2=[string1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *string3=[string2 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return string3;
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:self.startingTreeElement]) {
        self.search=YES; // this will overwrite each time - that's okay
        self.dictTempDataStorage = [[NSMutableDictionary alloc] init]; // create a new dict to hold the new XML feed data
        [self.attributeDict removeAllObjects];
        self.hasAttrDict=NO;
    }
    else if(self.search){
        if([attributeDict count]>0){
            self.hasAttrDict=YES;
            [self.attributeDict addEntriesFromDictionary:attributeDict];;
        }
    }
    
    
    self.currentElement = elementName;
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(self.search){
        if ([elementName isEqualToString:self.startingTreeElement]) {
            [self.xmlArray addObject:self.dictTempDataStorage]; // add the dictonary to the array
        }
        
        else{
            if(self.hasAttrDict){
                if(![self.foundValue isEqualToString:@""]){
                    [self.attributeDict addEntriesFromDictionary:@{elementName:[NSString stringWithString:[self cleanString:self.foundValue]]}];
                }
                NSDictionary *tempDIct=[[NSDictionary alloc] initWithDictionary:self.attributeDict];
                
                [self.dictTempDataStorage setObject:tempDIct forKey:elementName];
            }
            else{
                [self.dictTempDataStorage setObject:[NSString stringWithString:[self cleanString:self.foundValue]] forKey:elementName];
            }
        }
        
        
        [self.foundValue setString:@""];
        self.hasAttrDict=NO;
        
        
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(self.search){
        // we only care about this once search is set to YES becaucse some XML feeds create problems with the document head
        [self.foundValue appendString:string];
    }
}
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"ERROR : %@", [parseError localizedDescription]);
}

@end
