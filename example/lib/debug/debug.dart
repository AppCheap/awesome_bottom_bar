import 'package:flutter/foundation.dart' show kDebugMode;

/// DO avoid print calls in production code.
///
void avoidPrint(value) {
  if (kDebugMode) {
    print(value);
  }
}
