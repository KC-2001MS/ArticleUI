# ArticleUI

ArticleUI is a framework that allows you to display headings and content with simple code.

> [!WARNING]
> This package is currently under development.

## Description

With this library, you can display headings and content with simple SwiftUI code.
Depending on the platform, the design can be tailored to look beautiful.

## Requirement

The following environment is required to use this library.  

<p align="center">
    <img src="https://img.shields.io/badge/macOS-15.0+-red.svg" />
    <img src="https://img.shields.io/badge/iOS-18.0+-green.svg" />
    <img src="https://img.shields.io/badge/iPadOS-18.0+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/visionOS-2.0+-blue.svg" />
    <img src="https://img.shields.io/badge/tvOS-18.0+-white.svg" />
    <img src="https://img.shields.io/badge/Swift-6.0-DE5D43.svg" />
    <a href="https://twitter.com/IroIro1234work">
        <img src="https://img.shields.io/badge/Contact-@IroIro1234work-lightgrey.svg?style=flat" alt="Twitter: @IroIro1234work" />
    </a>
</p>

## Demo

To verify the operation of this library, we created a sample application in the library. Please refer to it.

## Usage

This framework can be easily implemented by simply adding Scenes. 


```swift
import SwiftUI
import ArticleUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Article {
                Text(String(repeating: "Content 1 ", count: 10))
            
                Section {
                    Text(String(repeating: "Content 2 ", count: 20))
                } header: {
                    Label("Header", systemImage: "2.circle")
                } footer: {
                    Text(String(repeating: "Footer 2 ", count: 10))
                }

                Section("Header 3") {
                    Text(String(repeating: "Content 3 ", count: 30))
                }
            }
            .navigationTitle("Static Content")
        }
    }
}
```

<img src="images/noneButton.png" style="height:400px;object-fit: contain;"> 

## Swift-DocC

Swift-DocC is currently being implemented.

[Documentation](https://kc-2001ms.github.io/ArticleUI/documentation/articleui)

## Install

Xcode is required to use this library.
However, it is currently under development and cannot be installed. We will let you know as soon as possible.  

## Contribution
See [CONTRIBUTING.md](https://github.com/KC-2001MS/ArticleUI/blob/main/CONTRIBUTING.md) if you want to make a contribution.

## Licence

[ArticleUI](https://github.com/KC-2001MS/ArticleUI/blob/main/LICENSE)

## Supporting

If you would like to make a donation to this project, please click here. The money you give will be used to improve my programming skills and maintain the application.   
<a href="https://www.buymeacoffee.com/iroiro" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" >
</a>  
[Pay by PayPal](https://paypal.me/iroiroWork?country.x=JP&locale.x=ja_JP)

## Author

[Keisuke Chinone](https://github.com/KC-2001MS)
