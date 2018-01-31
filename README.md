<p align="left">
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
<a href="https://cocoapods.org/pods/RichTextRow"><img src="https://img.shields.io/cocoapods/v/RichTextRow.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/EurekaCommunity/RichTextRow/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

## Introduction

RichTextRow is a Eureka custom row that allows us to display and edit html. 
This row is using a `WKWebView` to render a div containing `contenteditable=true` attribute.
Editing supports bold, italic and underline style, selectable from the long press menu.

## Usage

```swift
import Eureka
import RichTextRow

class ViewController: FormViewController {

    let html = "<div>This is a div</div>"

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section()
            <<< RichTextRow() { row in
                row.title = "Placeholder"
                row.value = html
            }
    }
}
```

## Requirements

* iOS 9.0+
* Xcode 9.0+
* Eureka 4.0

## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install RichTextRow, simply add the following line to your Podfile:

```ruby
pod 'RichTextRow', '~> 1.0'
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

To install RichTextRow, simply add the following line to your Cartfile:

```ogdl
github "EurekaCommunity/RichTextRow" ~> 1.0
```

## Customization
If you need to use custom CSS styles you can add them to `RichTextEditor.html` file.

## Author
* [Fabio Felici](https://github.com/fabfelici)