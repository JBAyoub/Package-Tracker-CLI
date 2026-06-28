import 'package:package__tracker__c_l_i/Repositories/tracking_repository_impl.dart';
import 'package:package__tracker__c_l_i/Services/tracking_service.dart';
import 'package:package__tracker__c_l_i/commands/track_command.dart';
import 'package:package__tracker__c_l_i/datasources/remote/tracking_api_client.dart';

Future<void> main(List<String> arguments) async {
  final apiClient = TrackingApiClient();
  final repository = TrackingRepositoryImpl(apiClient);
  final service = TrackingService(repository);
  final command = TrackCommand(service);
  await command.run(arguments);
}
