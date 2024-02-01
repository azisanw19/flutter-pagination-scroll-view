import 'package:flutter/material.dart';
import 'package:pagination_scroll_view/src/model/scroll_options.dart';

class PaginationScrollView extends StatefulWidget {
  /// Creates a widget that detects when the scroll is at the bottom of the page.
  const PaginationScrollView({
    Key? key,
    required this.pageChanged,
    this.threshold = 0.8,
    required this.child,
    this.initialPage = 1,
    this.scrollOptions = const ScrollOptions(),
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Callback function to load more data.
  /// The callback function will be called when the scroll is at the bottom of the page.
  /// The callback stops being called when the current page is equal to the previous page.
  final PageChanged<int> pageChanged;

  /// The minimum number of pixels scrolled before a scroll event is sent.
  /// The default value is 0.8.
  /// If the value is 0.8, the scroll event will be sent when the scroll is at 80% of the page.
  /// If the value is 1.0, the scroll event will be sent when the scroll is at 100% of the page.
  /// If the value is 0.0, the scroll event will be sent when the scroll is at 0% of the page.
  final double threshold;

  /// The initial page of the pagination.
  /// The default value is 1.
  /// If the value is 1, the first page will be 1.
  /// If the value is 2, the first page will be 2.
  /// If the value is 0, the first page will be 0.
  final int initialPage;

  final ScrollOptions scrollOptions;


  @override
  State<PaginationScrollView> createState() => _PaginationScrollViewState();
}

class _PaginationScrollViewState extends State<PaginationScrollView> {
  /// The current page of the pagination.
  late double _previousMaxScroll;

  /// The current page of the pagination.
  late int _currentPage;

  @override
  void initState() {
    _previousMaxScroll = 0.0;
    _currentPage = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      key: const Key("PaginationScrollView"),
      onNotification: _onNotification,
      child: SingleChildScrollView(
          physics: widget.scrollOptions.physics,
          reverse: widget.scrollOptions.reverse,
          scrollDirection: widget.scrollOptions.scrollDirection,
          keyboardDismissBehavior: widget.scrollOptions.keyboardDismissBehavior,
          child: widget.child
      ),
    );
  }

  /// Return false to allow the notification to continue to be dispatched to further ancestors.
  /// Return true to stop the notification dispatching process.
  bool _onNotification(ScrollNotification scrollNotification) {
    double maxScroll =
        scrollNotification.metrics.maxScrollExtent * widget.threshold;

    if (scrollNotification.metrics.pixels >= maxScroll &&
        maxScroll > _previousMaxScroll) {
      _previousMaxScroll = maxScroll;
      _currentPage++;
      widget.pageChanged(_currentPage);
      return false;
    } else {
      return true;
    }
  }
}

typedef PageChanged<T> = void Function(T page);