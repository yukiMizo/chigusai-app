import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local_data.dart';

final isLoggedInStudentProvider = StateProvider<bool>((ref) => false);
final isLoggedInStaffProvider = StateProvider<bool>((ref) => false);
final isLoggedInAdminProvider = StateProvider<bool>((ref) => false);
final canChangeKomi = StateProvider<bool>(
  (ref) => (ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInStaff || ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin),
);

final currentLoginStatusProvider = StateProvider<CurrentLoginStatus>((ref) => CurrentLoginStatus.notLoggedIn);

enum LoginType { student, staff, admin }

enum CurrentLoginStatus { notLoggedIn, loggedInStudent, loggedInStaff, loggedInAdmin }

class LoginDataManager {
  static String _stringToSaveLoginData(LoginType loginType) {
    switch (loginType) {
      case LoginType.student:
        return "isLoggedInStudent";
      case LoginType.staff:
        return "isLoggedInStaff";
      case LoginType.admin:
        return "isLoggedInAdmin";
    }
  }

  static Future login(
    WidgetRef ref,
    LoginType loginType,
  ) async {
    //ローカルデータの更新
    await LocalData.saveLocalData(_stringToSaveLoginData(loginType), true);
    //プロバイダーの更新
    await setLoginDataProviderDataFromLocal(ref);
  }

  static Future logout(WidgetRef ref) async {
    //ローカルデータの更新
    await LocalData.saveLocalData(_stringToSaveLoginData(LoginType.student), false);
    await LocalData.saveLocalData(_stringToSaveLoginData(LoginType.staff), false);
    await LocalData.saveLocalData(_stringToSaveLoginData(LoginType.admin), false);
    //プロバイダーの更新
    await setLoginDataProviderDataFromLocal(ref);
  }

  static Future setLoginDataProviderDataFromLocal(WidgetRef ref) async {
    final bool isLoggedInStudent = await LocalData.readLocalData<bool>(_stringToSaveLoginData(LoginType.student)) ?? false;
    final bool isLoggedInStaff = await LocalData.readLocalData<bool>(_stringToSaveLoginData(LoginType.staff)) ?? false;
    final bool isLoggedInAdmin = await LocalData.readLocalData<bool>(_stringToSaveLoginData(LoginType.admin)) ?? false;

    //set current login status
    if (isLoggedInStudent) {
      ref.read(currentLoginStatusProvider.notifier).state = CurrentLoginStatus.loggedInStudent;
    } else if (isLoggedInStaff) {
      ref.read(currentLoginStatusProvider.notifier).state = CurrentLoginStatus.loggedInStaff;
    } else if (isLoggedInAdmin) {
      ref.read(currentLoginStatusProvider.notifier).state = CurrentLoginStatus.loggedInAdmin;
    } else {
      ref.read(currentLoginStatusProvider.notifier).state = CurrentLoginStatus.notLoggedIn;
    }

    //set provider data
    ref.read(isLoggedInStudentProvider.notifier).state = isLoggedInStudent;
    ref.read(isLoggedInStaffProvider.notifier).state = isLoggedInStaff;
    ref.read(isLoggedInAdminProvider.notifier).state = isLoggedInAdmin;
  }
}
