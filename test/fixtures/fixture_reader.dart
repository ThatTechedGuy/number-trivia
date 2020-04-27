import 'dart:io';

import 'package:path/path.dart' as p;

String fixture(String name) =>
    File('test/fixtures/$name').readAsStringSync();
