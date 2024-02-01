import 'package:flutter/material.dart';

class ScrollOptions {


  const ScrollOptions({
    this.physics,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  /// How the scroll view should respond to user input.
  /// For example, determines how the scroll view continues to animate after the user stops dragging the scroll view.
  /// Defaults to matching platform conventions.
  /// See documentation for [ScrollPhysics] for more details.
  final ScrollPhysics? physics;

  /// The direction along which the scroll view scrolls.
  final bool reverse;

  /// The axis along which the scroll view scrolls.
  /// Defaults to [Axis.vertical].
  /// See documentation for [Axis] for more details.
  final Axis scrollDirection;

  /// How the scroll view should respond to user input to dismiss the current primary
  /// keyboard.
  /// Defaults to [ScrollViewKeyboardDismissBehavior.manual].
  /// See documentation for [ScrollViewKeyboardDismissBehavior] for more details.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;


}