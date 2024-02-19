# Pagination Scroll View

[![Flutter Package](https://img.shields.io/pub/v/pagination_scroll_view.svg)](https://pub.dev/packages/pagination_scroll_view)
[![Pub Points](https://img.shields.io/pub/points/pagination_scroll_view)](https://pub.dev/packages/pagination_scroll_view/score)
[![Popularity](https://img.shields.io/pub/popularity/pagination_scroll_view)](https://pub.dev/packages/pagination_scroll_view/score)

Pagination Scroll View Widget for Flutter

## Getting Started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  pagination_scroll_view: ^1.1.2
```

## Usage

Basic usage of this widget is as below:

### PaginationScrollView

```dart
PaginationScrollView(
    key: const Key("pagination_scroll_view"),
    pageChanged: (page) {
      setState(() {
        _itemCount += 20;
      });
    },
    threshold: 0.8,
    scrollOptions: const ScrollOptions(
      physics: BouncingScrollPhysics(),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 200,
          color: Colors.red,
          child: const Center(
            child: Text("Header"),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Item $index"),
            );
          },
          itemCount: _itemCount,
        ),
      ],
    ),
);
```

## Contribution

We welcome contributions! Feel free to open issues or submit pull requests.

## License

This package is licensed under the Apache V2 License - see the [LICENSE](LICENSE) file for details.