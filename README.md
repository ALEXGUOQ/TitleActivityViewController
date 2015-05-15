# TitleActivityViewController
iOS system provided share sheet with custom title. Inspired by the [an0/WLActivityViewController](https://github.com/an0/WLActivityViewController). It provides you a chance to use pure Swift alternation in your next app.

## Usage
```swift
let title = "Title"
let tavc = TitleActivityViewController(activityItems: [title], applicationActivities: nil)
        
// option 1
tavc.title = title
// option 2
// tavc.setTitle("Title")
// option 3
// tavc.setTitle("Title", font: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), numberOfLines: 3, textAlignment: NSTextAlignment.Left)

tavc.popoverPresentationController?.barButtonItem = sender
        
presentViewController(tavc, animated: true, completion: nil)
```

## Requirements
- iOS 8.0+
- Xcode 6.3+ (Swift 1.2+)

## License
TitleActivityViewController is released under the MIT license.

## The MIT License (MIT)

Copyright (c) 2015 Jonny

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
