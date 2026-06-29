import 'package:package__tracker__c_l_i/Models/Parcel.dart';

abstract class TrackingRepository {
  Future<Parcel?> getTrackInfo({
    required String? trackNumber,
    required String? key,
    required String? carrier,
  });

  Future<String?> registerTrackingNumber({
    required String? key,
    required String? trackNumber,
  });
}
