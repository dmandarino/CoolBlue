# CoolBlue

An app that should help users search for products and take a look at their details. 


## Overview

Scroll indefinitely through listing screen and find interesting products to buy. You can also search using the Search Bar. When you find something that interest you, select it and checkout some more details about it.

## Getting Started

### Prerequisites

XCode 9+    
iOS 11.0+    
Cocoapods


### Installing

After you clone the project, you'll need install [CocoaPods](https://cocoapods.org/)

#### CocoaPods

In your terminal run:

```
pod install
```

Now you can open __CoolBlue.xcworkspace__

## Gitflow

This project uses Gitflow. So, do not forget checking `develop` branch. Maybe it's ahead of master.

## Architecture

In this project I'm using VIPER. 
But also, I used some patterns proposed in Clean Swift, such as Configurator and Worker. You can check over [here](https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf)

## Dependencies

```
 Alamofire ~> 4.7
 AlamofireImage ~> 3.3
 SwiftyJSON ~> 4.0
 SkeletonView latest
 Cosmos ~> 16.0
 ```
[Alamofire](https://github.com/Alamofire/Alamofire) is an HTTP networking library written in Swift.    
[AlamofireImage](https://github.com/Alamofire/AlamofireImage) is an image component library for Alamofire.     
[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) makes it easy to deal with JSON data in Swift.     
[SkeletonView](https://github.com/Juanpe/SkeletonView) is an elegant way to show users that something is happening and also prepare them to which contents he is waiting.      
[Cosmos](https://github.com/evgenyneu/Cosmos/) shows a star rating and takes rating input from the user. Cosmos is a subclass of a UIView that will allow your users to post those inescapable 1-star reviews!
