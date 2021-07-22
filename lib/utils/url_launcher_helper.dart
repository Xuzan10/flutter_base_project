import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static launchPhone(String? number) async {
    if (number == null || number == "") return;

    await launch('tel:$number');
  }

  static launchSite(String? site) async {
    if (site == null && site != "") {
      return;
    }

    try {
      await launch(site!);
    } catch (e) {
      print('error launching $site ===== $e');
    }
  }

  static launchEmail(String? email) async {
    if (email == null || email == "") {
      return;
    }

    try {
      await launch('mailto:$email');
    } catch (e) {
      print('error launching $email ===== $e');
    }
  }
}
