# SYBadgeButton
SYBadgeButton can customize badge button that you want.

## Screenshots
![](Screenshots/Screenshot1.png)

## Examples

Support Storyboard or init method

```swift
let rect = CGRect(x: 20, y: 20, width: 100, height: 50)
let badgeButton = SYBadgeButton(frame: rect)
badgeButton.setTitle("button", for: .normal)
badgeButton.setTitleColor(UIColor.black, for: .normal)
view.addSubview(badgeButton)
```

Add your badge Value

```swift
badgeButton.badgeValue = "20"
```

Customize badge color

```swift
badgeButton.badgeBackgroundColor = UIColor.brown
badgeButton.badgeTextColor = UIColor.white
```

Have several of positions

```swift
// This is topLeft position
badgeButton.badgePositionIndex = 1
```

also you can use badge offset and edge inset

```swift
// Custom offset and edge inset
badgeButton.badgeOffset = CGPoint(x: 3, y: 3)
badgeButton.leftEdgeInset = 10
badgeButton.rightEdgeInset = 10
badgeButton.topEdgeInset = 5
badgeButton.bottomEdgeInset = 5
```

## Licence
SYBadgeButton is available under the MIT license. See the [MIT License](LICENSE) for more info.
