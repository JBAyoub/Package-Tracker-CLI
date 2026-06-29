import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:package__tracker__c_l_i/Models/Parcel.dart';

void main() {
  group('Parcel.fromJson()', () {
    test('Should return a valid Parcel from valid Json ', () async {
      //Arrange
      final file = File('data/sample_data.json');
      final jsonString = await file.readAsString();
      final Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      // Act
      final parcel = Parcel.fromJson(json);
      //Assert
      expect(parcel, isA<Parcel>());
      expect(parcel.carrier, "Fedex");
      expect(parcel.status, "Shipment information sent to FedEx");
    });
  });
}
