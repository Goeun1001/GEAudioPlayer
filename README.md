# GEAudioPlayer

[![Version](https://img.shields.io/cocoapods/v/GEAudioPlayer.svg?style=flat)](https://cocoapods.org/pods/GEAudioPlayer)
[![Platform](https://img.shields.io/cocoapods/p/GEAudioPlayer.svg?style=flat)](https://cocoapods.org/pods/GEAudioPlayer)
[![License](https://img.shields.io/cocoapods/l/GEAudioPlayer.svg?style=flat)](https://cocoapods.org/pods/GEAudioPlayer)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-4BC51D.svg?style=flat)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

A sample audio player for tutorial



## Requirements

- iOS 11+
- Swift 5+



## Usage

```swift
struct ContentView: View {
    @State var date: Date? = Date()
    var body: some View {
        GECalendar(selectedDate: $date, appearance: Appearance())
    }
}
```

```swift
struct ContentView: View {
    @State var date: Date? = Date()
    var body: some View {
        GEWeekView(selectedDate: $date, appearance: Appearance())
    }
}
```

You can manage settings with GECalendar's [Appearance](https://github.com/Goeun1001/GECalendar/blob/master/Sources/GECalendar/Shared/Appearance.swift).



## Installation

### CocoaPods

```
pod 'GECalendar'
```

### Carthage

```
github "Goeun1001/GECalendar"
```

### SPM

```
.package(url: "https://github.com/Goeun1001/GECalendar.git", from: "1.0.0")
```



## Author

goeun1001, [gogo8272@gmail.com](mailto:gogo8272@gmail.com)



## License

GEAudioPlayer is available under the MIT license. See the LICENSE file for more info.