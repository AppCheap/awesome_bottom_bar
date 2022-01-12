/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'transition_container.dart';

/// Interface to provide a transition, work with [TransitionContainer].
abstract class TransitionContainerBuilder<T> {
  /// Curve for animation.
  final Curve curve;

  /// Create style builder.
  TransitionContainerBuilder(this.curve);

  /// Animation used for widget.
  Animation animation(AnimationController controller);

  /// Return animated widget with provided animation.
  Widget build(Animation<T> animation);
}

/// Scale transition builder.

class ScaleBuilder extends TransitionContainerBuilder<double> {
  /// The target widget to scale with.
  Widget child;

  @override
  Animation animation(AnimationController controller) {
    return Tween(begin: pi / 6, end: pi / 3).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  @override
  Widget build(Animation<double> animation) {
    return ScaleTransition(scale: animation, child: child);
  }

  /// Create scale builder
  ScaleBuilder({required Curve curve, required this.child}) : super(curve);
}

class FlipBuilder extends TransitionContainerBuilder<double> {
  /// Bottom widget.
  final Widget bottomChild;

  /// Size of builder.
  final double height;

  /// Create flip builder
  FlipBuilder(
    this.height, {
    required Curve curve,
    required this.bottomChild,
  }) : super(curve);

  @override
  Animation animation(AnimationController controller) {
    return Tween(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  @override
  Widget build(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0.0, (cos(animation.value) * (height / 6)), 0),
        child: Center(child: bottomChild),
      ),
    );
  }
}
