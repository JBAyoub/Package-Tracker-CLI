import 'package:package__tracker__c_l_i/Models/Parcel.dart';
import 'package:package__tracker__c_l_i/Repositories/tracking_repository.dart';

class TrackingService {
  final TrackingRepository repository;

  TrackingService(this.repository);

  Future<Parcel?> track(String? key, String? trackNumber) async {
    final String? carrier = await repository.registerTrackingNumber(
      key: key,
      trackNumber: trackNumber,
    );
    return await repository.getTrackInfo(
      trackNumber: trackNumber,
      key: key,
      carrier: carrier,
    );
  }
}
