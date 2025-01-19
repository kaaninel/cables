library kablo;

/// The `kablo` library is a powerful library that helps you harness the full potential of Dart's streams for state management.
/// It provides various classes, mixins, and extensions to create and manage duplex streams, define module inputs and outputs, and leverage additional functionality.

import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:async/async.dart';

export 'dart:async';
export 'package:async/async.dart';
export 'package:stream_transform/stream_transform.dart';
export 'controller.dart';

part 'stream/base.dart'; // Contains mixins and classes for input, output, and processing streams.
part 'stream/log.dart'; // Contains logging configurations and mixins for input and output logging.
part 'stream/async.dart'; // Contains the Waiter mixin for managing asynchronous tasks.
part 'stream/cache.dart'; // Contains mixins and classes for caching and state management.
part 'stream/stat.dart'; // Contains mixins and classes for tracking input and output counts, and lag.
part 'stream/collection.dart'; // Contains classes for aggregating and merging streams.
part 'stream/extensions.dart'; // Contains extensions for additional stream functionalities.
part 'stream/widgets.dart'; // Contains extensions and functions for building widgets with streams.
