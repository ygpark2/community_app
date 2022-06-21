import 'package:layout/layout.dart';
import 'package:flutter/material.dart';

/// Returns a boolean value whether the window is considered medium or large size.
///
/// Used to build adaptive and responsive layouts.
bool isDisplayTablet(BuildContext context) =>
    context.breakpoint <= LayoutBreakpoint.md && context.breakpoint > LayoutBreakpoint.sm;

/// Returns boolean value whether the window is considered medium size.
///
/// Used to build adaptive and responsive layouts.
bool isDisplayDesktop(BuildContext context) =>
    context.breakpoint > LayoutBreakpoint.md;
