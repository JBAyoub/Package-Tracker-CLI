import 'dart:io';

import 'package:args/args.dart';
import 'package:package__tracker__c_l_i/Services/tracking_service.dart';
import 'package:package__tracker__c_l_i/datasources/local/api_key_storage.dart';
import 'package:package__tracker__c_l_i/utils/validators.dart';

class TrackCommand {
  Validators v = Validators();
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false)
    ..addOption('tnumber', abbr: 't', help: 'Tracking number to look up.');

  final TrackingService service;
  final ApiKeyStorage storage = ApiKeyStorage();
  TrackCommand(this.service);
  Future<void> run(List<String> arguments) async {
    final key = await storage.getApiKey();

    if (key == null) {
      print("No API key found.");
      return;
    }
    final trackingNumber = await getTrackNumberFromUser(arguments);
    if (trackingNumber == null) {
      return;
    }
    try {
      final parcel = await service.track(key, trackingNumber);
      print(parcel ?? "Couldn't find parcel :( ");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getTrackNumberFromUser(List<String> inputArgs) async {
    final String? tnumber;
    final ArgResults results;
    try {
      results = parser.parse(inputArgs);
      if (results['help']) {
        print(parser.usage);
        return null;
      }
    } on FormatException catch (e) {
      print(e.message);
      return null;
    }

    if (results['tnumber'] == null) {
      print("Please provide a tracking number");
      tnumber = askForTrackingNumber();
    } else {
      tnumber = results['tnumber']!;
    }
    return tnumber;
  }

  String askForTrackingNumber() {
    String? input;
    do {
      print("Example: 'RR123456789CN'");
      input = stdin.readLineSync() ?? '';
    } while (!v.validTrackNumber(input));
    return input;
  }
}
