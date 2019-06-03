import 'package:places_api/places_api.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:places_api/places_api.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for places_api.
///
/// A harness for testing an aqueduct application. Example test file:
///
        //  void main() {
        //    Harness harness = Harness()..install();
        //    test("GET /example returns 200", () async {
        //      final response = await harness.agent.get("/path");
        //      expectResponse(response, 200);
        //    });
        //  }
///
class Harness extends TestHarness<PlacesApiChannel> {
  @override
  Future onSetUp() async {

  }

  @override
  Future onTearDown() async {

  }
}
