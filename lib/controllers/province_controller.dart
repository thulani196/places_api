import 'package:places_api/places_api.dart';

class ProvinceController extends ResourceController {

  @Operation.get()
  Future<Response> getAllProvinces() async {

    var provinces = [
        {"id": 1, "name": "Lusaka"},
        {"id": 2, "name": "Central Province"},
        {"id": 3, "name": "Southern Province"},
        {"id": 4, "name": "Western Province"}
    ];

    return Response.ok(provinces);

  }

}