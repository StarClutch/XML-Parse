# XML-Parse
Easy to use XML Parser that outputs in dictionary format written in Objective-C.

[![CI Status](http://img.shields.io/travis/Blake/XML-Parse.svg?style=flat)](https://travis-ci.org/Blake/XML-Parse)
[![Version](https://img.shields.io/cocoapods/v/XML-Parse.svg?style=flat)](http://cocoapods.org/pods/XML-Parse)
[![License](https://img.shields.io/cocoapods/l/XML-Parse.svg?style=flat)](http://cocoapods.org/pods/XML-Parse)
[![Platform](https://img.shields.io/cocoapods/p/XML-Parse.svg?style=flat)](http://cocoapods.org/pods/XML-Parse)

## Example
1. Run `pod try XML-Parse`.
2. If `pod try` does not work: clone the repo, and run `pod install` from the Example directory first. 

## Requirements
iOS 9.0+

## Installation

XML-Parse is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XML-Parse"
```


## Usage

First of all, init your XMLParse class:

```ruby
XMLParse *parse=[[XMLParse alloc] initWithParseURL:@"URL.xml"];
```

Next set the delegate (to it's caller) and call the method `parse`:

```ruby
parse.delegate=(id)self;
[parse parse];
```

Finally receive the success or fail notifications using:

```ruby
-(void)XMLParseDidFinishSuccessfully:(NSArray *)xml{
    NSLog(@"Success");
    NSLog(@"%@",xml);
}
-(void)XMLParseDidFail{
    #warning - handle failed XML parse here
    NSLog(@"Failed VC Parse");
}
```


## Author

Blake, shetter.blake@gmail.com

## License

XML-Parse is available under the MIT license. See the LICENSE file for more info.
