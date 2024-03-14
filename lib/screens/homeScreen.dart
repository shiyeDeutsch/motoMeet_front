import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/isar_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isarService = GetIt.I<IsarService>();
    print(isarService.getallSync().length);

    var user = isarService.getUserAsync();
    return Container(height: 500,
        child: Text(user!.id.toString() +
            user.firstName.toString() +
            user.lastName.toString()));
  }
}
