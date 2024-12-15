import 'package:appwrite/appwrite.dart';

class AppwriteProvider {
  late final Client client;
  late final Account account;

  AppwriteProvider() {
    client = Client()
      ..setEndpoint("https://cloud.appwrite.io/v1") // Replace with your Appwrite endpoint
      ..setProject("674feddb0035133d8a2a"); // Replace with your Appwrite project ID

    account = Account(client);
  }
}

final appwriteProvider = AppwriteProvider();
