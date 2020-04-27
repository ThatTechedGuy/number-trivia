import 'dart:io';

import 'package:path/path.dart' as p;

String fixture(String name) =>
    File('${p.current}/fixtures/$name').readAsStringSync();
