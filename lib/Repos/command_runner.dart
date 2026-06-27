import 'dart:io';

import 'package:args/args.dart';
import 'package:package__tracker__c_l_i/Repos/HTTPReq.dart';
import 'package:package__tracker__c_l_i/Repos/RetrieveKey.dart';

final parser = ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false)
  ..addOption('tnumber', abbr: 't', help: 'Tracking number to look up.');

Future<void> trackPack(List<String>? inputArgs) async {
  final String? key;
  final String? tnumber;
  ArgResults results;
  if (inputArgs == null || inputArgs.isEmpty) {
    print(parser.usage);
    print("No arguments were provided. Exiting");
    return;
  } else {
    if (await getApiKey() == null) {
      print("API Key not found.");
      await saveAPIKey();
    }
    key = await getApiKey();
    try {
      results = parser.parse(inputArgs);
      if (results['help']) {
        print(parser.usage);
        return;
      }
    } on FormatException catch (e) {
      print(e.message);
      print("Please provide a tracking number");
      return;
    }

    if (results['tnumber'] == null) {
      tnumber = askForTrackingNumber();
    } else {
      tnumber = results['tnumber']!;
    }
  }
  try {
    await getTrackInfo(trackNumber: tnumber!, key: key!);
  } on RangeError catch (e) {
    print(
      "Package could not be found! Error: ${e.message} \nPlease check the tracking number and try again.",
    );
  }
}

String askForTrackingNumber() {
  String input;
  do {
    print("Example: 'RR123456789CN'");
    print("Please enter a valid Tracking Number:");
    input = stdin.readLineSync() ?? '';
  } while (!validTrackNumber(input));
  return input;
}

bool validTrackNumber(String? number) {
  if (number == null || number.isEmpty) {
    print("Key can't be empty or null ");
    return false;
  }
  final trackingRegex = RegExp(r'^[A-Z0-9]{10,30}$');
  if (!trackingRegex.hasMatch(number)) {
    print(
      "The Tracking Number you provided has the wrong the format \n please provide a correct Tracking Number",
    );
    return false;
  }
  return true;
}
