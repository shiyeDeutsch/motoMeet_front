import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/isar/isar_user_info.dart';
import '../services/isar/reposetory_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isarService = GetIt.I<RepositoryProvider>().userInfoRepository;

    var user = isarService.getLastSync();
    return Container(
        height: 500,
        child: Text(user!.id.toString() +
            user.firstName.toString() +
            user.lastName.toString()));
  }
}
