import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/routing/routes.dart';

import '../services/isar/isar_user_info.dart';

 
import '../services/isar/repository_provider.dart';
import '../widgets/bottomNavigation.dart';
 
class RouteService{
static Future<String> getInitialRoute() async {
  
  final isarService = GetIt.I<RepositoryProvider>().userInfoRepository;
   // await isarService.clearUser();
  final token = await isarService.getToken();
  //  print(isarService.getAll());
  return token != null ? Routes.homePage : Routes.login;
}
 static Widget  showBottomNav(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name ?? '');
    bool showNav = true;
    if ((ModalRoute.of(context)?.settings.name ?? '') == Routes.login ||
        (ModalRoute.of(context)?.settings.name ?? '') == Routes.signUp) {
      showNav = false;
    }

    return showNav ?  BottomNavigation ():Container();
  
  }
}

