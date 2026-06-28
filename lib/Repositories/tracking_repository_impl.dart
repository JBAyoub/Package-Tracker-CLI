import 'package:package__tracker__c_l_i/Models/Parcel.dart';
import 'package:package__tracker__c_l_i/Repositories/tracking_repository.dart';
import 'package:package__tracker__c_l_i/datasources/remote/tracking_api_client.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingApiClient api;
  TrackingRepositoryImpl(this.api);

  @override
  Future<Parcel> getTrackInfo({
    required String? trackNumber,
    required String? key,
    String? carrier,
  }) async {
    final json = await api.get17TrackData(key, trackNumber, carrier);
    return Parcel.fromJson(json!);
  }

  @override
  Future<String?> registerTrackingNumber({
    required String? key,
    required String? trackNumber,
  }) async {
    final String? carrier = await api.registerTrackingNumbers(
      APIkey: key,
      trackingNumber: trackNumber,
    );
    return carrier;
  }
}
