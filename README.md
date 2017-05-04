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

* iOS 8.0+
* Xcode 8.0+
* Eureka 2.0.*

## Customization
If you need to use custom CSS styles you can add them to `RichTextEditor.html` file.