# Progressable
[![Build Status](https://travis-ci.org/MartinMoizard/Progressable.svg?branch=master)](https://travis-ci.org/MartinMoizard/Progressable)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Progressable.svg)](https://img.shields.io/cocoapods/v/Progressable.svg)

Progressable is a simple component to help you add a simple **animatable progress bar** to any UIView.

## Usage

3 simple stops to follow:

- make your `UIView` conform to the `Progressable` protocol.
- call `self.initProgress()` in `init(frame: CGRect)` and `init?(coder aDecoder: NSCoder)`.
- call `self.layoutProgress()` in `func layoutSubviews()`.

## API

After conforming to the `Progressable` protocol, you change the progress using:

- the `progress` property: `self.progressView.progress = 50` (values are from 0 to 100).
- the `setProgress(progress: CGFloat, withDuration duration: TimeInterval)` method.

The following properties can be customized:

- `progressLineWidth`: width of the progress bar.
- `progressColor`: color of the progress bar.

## Example

```swift
class ProgressSearchBar: UISearchBar, Progressable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initProgress()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initProgress()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutProgress()
    }
}
```

This example can be run using `Progressable.xcodeproj`.

## Preview

![progress](https://cloud.githubusercontent.com/assets/395477/18714291/9620e9a0-8015-11e6-9552-34b2bc9b8467.gif)
