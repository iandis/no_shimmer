# NoShimmer
A simple colored box widget, typically used for showing loading indicator. This is the opposite of shimmer, which has no animation/effects.

This widget is aimed to replace `Container` for creating a single colored box. Why? Because `Container` cannot be created using the `const` keyword.

### Using

```dart
import 'package:no_shimmer/no_shimmer.dart'
```

```dart
const NoShimmer(
    width: 200, // optional, defaults to BoxConstraints.maxWidth
    height: 200, // optional, defaults to BoxConstraints.maxHeight
    color: Colors.grey, // optional, defaults to Colors.grey[200]
    padding: EdgeInsets.all(10), // optional
    borderRadius: BorderRadius.all(Radius.circular(20)), // optional
);
```

Note that to use `borderRadius` with the `const` keyword available, define `borderRadius` with any `BorderRadius` constructors but the `BorderRadius.circular`.