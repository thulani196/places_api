

import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class ProvinceController extends ResourceController {

  ProvinceController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllProvinces() async {

    final query = Query<Province>(context);
    final res = await query.fetch();

    return Response.ok(res);

  }

}