// ignore: file_names
import 'dart:io';

final regEx = RegExp(r'^[A-Z0-9]{32}$');
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
    return null;
  }
  final content = await env.readAsString();
  if (!content.startsWith('API_KEY=')) {
    return null;
  }
  return content.substring('API_KEY='.length).trim();
}

bool isValid(String? key) {
  if (key == null || key.isEmpty) {
    print("Key can't be empty or null ");
    return false;
  }
  if (!regEx.hasMatch(key)) {
    print(
      "The key you provided has the wrong the format \n please provide a correct 17TRACK API key",
    );
    return false;
  }
  return true;
}

String askForKey() {
  String input;
  do {
    print("Please enter a valid 17TRACK API Key:");
    input = stdin.readLineSync() ?? '';
  } while (!isValid(input));
  return input;
}
