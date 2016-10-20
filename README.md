Cheetah
======

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
![Pod Version](https://img.shields.io/badge/Pod-0.4.1-blue.svg)
![Swift Version](https://img.shields.io/badge/Swift-3.0-orange.svg)
![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Plaforms](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)

Cheetah is an animation utility on iOS with Swift. Cheetah can animate any properties
since Cheetah uses simple CADisplayLink run loop to change animated properties.

Requirements
----

- iOS 8.0~
- Swift 3.0

Features
----

- Animation with duration and delay
- Changing with absolute/relative properties
- Parallel/Serial executions
- Easings
- Springs

Carthage
----

Carthage is a simple, decentralized dependency manager for Cocoa.

To install Cheetah, simply add the following line to your Cartfile:

```
github "suguru/Cheetah"
```

Code Example
----

```swift
// Create view
let box = UIView(frame:CGRectMake(100,100,50,50))
box.backgroundColor = UIColor.blueColor()
view.addSubview(box)

// Move to 100px right
box.cheetah.move(100, 0).run()
```

![Simple move](https://suguru.github.io/Cheetah/images/simple_move.gif)

Properties
----

Cheetah has several methods to animate properties easily. You can also animate your own properties with extending CheetahProperty.

- move
- position (absolute of move)
- scale
- rotate
- rotation (absolute of rotate)
- size
- frame
- alpha
- backgroundColor
- textColor
- borderColor
- borderWidth
- borderRadius
- custom properties

Parallel execution
----

Cheetah groups animation properties and execute them at once.

```swift
view.cheetah
  .move(100, 0)
  .rotate(M_PI * 2)
  .scale(1.5)
  .run()
```

![Parallel](https://suguru.github.io/Cheetah/images/parallel_move.gif)

Serial execution
----

`wait` will wait until all animations placed before it completed.
It can also receive seconds to wait to start next animation.

```swift
view.cheetah
  .move(100, 0).rotate(M_PI)
  .wait()
  .move(-100, 0).rotate(-M_PI)
  .wait(1.0) // <- wait 1 sec to start next animation
  .move(0, -20).duration(0.4)
  .wait()
  .move(0, 20).duration(0.4)
  .run()
```

![Serial](https://suguru.github.io/Cheetah/images/serial_move.gif)

Duration and delay
----

Cheetah has duration and delay to each animation properties.

```swift
view.cheetah
  .move(100, 0).duration(1.0).delay(1.0)
  .rotate(M_PI).duration(2.0)
  .wait(1)
  .move(-100, 0).duration(0.4)
  .run()
```

![Delay](https://suguru.github.io/Cheetah/images/delay_move.gif)

Duration will be copied from the property placed before.

```swift
view.cheetah
  .duration(0.5)
  .move(100, 0) // <- will have 0.5 sec duration
  .rotate(M_PI) // <- will have 0.5 sec duration
  .run()
```

Repeating
----

To repeat animations, use `repeatCount(count: Int)`

```swfit
view.cheetah.rotate(M_PI_2).run().repeat(3)
```

To repeat forever, use `forever`

```swift
view.cheetah.rotate(M_PI_2).run().forever
```
![Repeat](https://suguru.github.io/Cheetah/images/repeat_move.gif)

Easings
----

Cheetah supports various easing functions. You can also add custom easings with quad bezier points.

![Easings](https://suguru.github.io/Cheetah/images/easings.gif)

Exmaple

```swift
view.cheetah.move(150, 150).easeInQuad.run()
```

Supported eassing equations

- Linear
- Sine
- Quad
- Quart
- Quint
- Circ
- Cubic
- Expo
- Back
- Bounce
- Elastic

Springs
----

Cheetah supports spring dynamics with tension and friction parameters.

![Springs](https://suguru.github.io/Cheetah/images/springs.gif)

Example

```swift
view.cheetah
  .move(200, 0)
  .spring()
  .run()

view.cheetah
  .move(200, 0)
  .spring(tension: 100, friction: 4)
  .run()
```

Animate custom properties
----

You can extend CheetahProperty to animate custom properties. You can refer CheetahViewProperties.swift and CheetahLayerProperties.swift.

:)
