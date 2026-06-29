import 'package:package__tracker__c_l_i/utils/validators.dart';
import 'package:test/test.dart';

void main() {
  group("Tracking Number Valid Formats", () {
    test(" tracking number is empty", () {
      expect(Validators().validTrackNumber(""), false);
    });
    test("tracking number is all spaces", () {
      expect(Validators().validTrackNumber("   "), false);
    });
    test("Tracking number has special chars", () {
      expect(Validators().validTrackNumber("6546!*+-/==)ç_5645"), false);
    });
    test("Tracking number should be valid", () {
      expect(Validators().validTrackNumber("LA225641500AE"), true);
    });
  });
  group("Correct API Key format", () {
    test("API Key is empty", () {
      expect(Validators.isValid(""), false);
    });
    test("API Key is all spaces", () {
      expect(Validators.isValid("                                 "), false);
    });
    test("API Key has special chars", () {
      expect(Validators.isValid("AADSQDQSDSQCSQCQ6546!*+-/==)ç_QSD"), false);
    });
    test("API key should be valid", () {
      expect(Validators.isValid("356A2LK8PO6978S54F58G4E545SS787Z"), true);
    });
  });
}
