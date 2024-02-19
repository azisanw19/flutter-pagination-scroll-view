import 'package:flutter/material.dart';
import 'package:pagination_scroll_view/src/model/refresh_options.dart';
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
    this.onRefresh,
    this.refreshOptions = const RefreshOptions(),
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

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  /// only can use if [ScrollOptions.scrollDirection] is [Axis.vertical]
  final RefreshCallback? onRefresh;

  final RefreshOptions refreshOptions;

  @override
  State<PaginationScrollView> createState() => _PaginationScrollViewState();
}

class _PaginationScrollViewState extends State<PaginationScrollView> {
  /// The current page of the pagination.
  late double _previousMaxScroll;

  /// The current page of the pagination.
  late int _currentPage;

  late Key _singleChildScrollViewKey;

  /// Set the initial value of the pagination.
  void _setInitialValue() {
    _previousMaxScroll = 0;
    _currentPage = widget.initialPage;
  }

  @override
  void initState() {
    _setInitialValue();
    _singleChildScrollViewKey = const Key("SingleChildScrollView");
    super.initState();
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
    }

    return widget.refreshOptions.notificationPredicate(scrollNotification);
  }

  Widget _containsSingleChildScrollView(Widget child) {
    return SingleChildScrollView(
      key: _singleChildScrollViewKey,
      physics: widget.scrollOptions.physics,
      reverse: widget.scrollOptions.reverse,
      scrollDirection: widget.scrollOptions.scrollDirection,
      keyboardDismissBehavior: widget.scrollOptions.keyboardDismissBehavior,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefresh != null) {
      return RefreshIndicator.adaptive(
        key: const Key("RefreshIndicator"),
        onRefresh: () {
          _setInitialValue();
          return widget.onRefresh!();
        },
        backgroundColor: widget.refreshOptions.backgroundColor,
        color: widget.refreshOptions.color,
        displacement: widget.refreshOptions.displacement,
        edgeOffset: widget.refreshOptions.edgeOffset,
        notificationPredicate: _onNotification,
        semanticsLabel: widget.refreshOptions.semanticsLabel,
        semanticsValue: widget.refreshOptions.semanticsValue,
        strokeWidth: widget.refreshOptions.strokeWidth,
        triggerMode: widget.refreshOptions.triggerMode,
        child: _containsSingleChildScrollView(widget.child),
      );
    } else {
      return NotificationListener<ScrollNotification>(
        key: const Key("PaginationScrollView"),
        onNotification: _onNotification,
        child: _containsSingleChildScrollView(widget.child),
      );
    }
  }
}

typedef PageChanged<T> = void Function(T page);
