import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /example returns 200 {'key': 'value'}", () async {
    expectResponse(await harness.agent.get("/api/provinces"), 
      200, body: everyElement ({
        "id": isInteger,
        "name": isString,
        "longitude": isString,
        "latitude": isString,
        "population": isNotNull
      }));
  });

}
