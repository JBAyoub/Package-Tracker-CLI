import 'dart:io';
import 'package:package__tracker__c_l_i/utils/validators.dart';

class ApiKeyStorage {
  Future<void> saveAPIKey() async {
    String key = askForKey();
    const envPath = '.env';
    final env = File(envPath);
    if (!await env.exists()) {
      print("File '.env' doesn't exist");
      print("Attempting to create");
      try {
        await env.create();
      } on PathNotFoundException catch (e) {
        print(e.message);
        return;
      }
    }
    if (await env.readAsString() != '') {
      print("An API key already exists.");
      return;
    }
    await env.writeAsString("API_KEY=$key");
  }

  Future<String?> getApiKey() async {
    final env = File('.env');
    if (!await env.exists()) {
      await saveAPIKey();
    }
    final content = await env.readAsString();
    return content.substring('API_KEY='.length).trim();
  }

  String askForKey() {
    String input;
    do {
      print("Please enter a valid 17TRACK API Key:");
      input = stdin.readLineSync() ?? '';
    } while (!Validators.isValid(input));
    return input;
  }
}
