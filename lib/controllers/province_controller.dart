

import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class ProvinceController extends ResourceController {

  ProvinceController(this.context);
  final ManagedContext context;

  // Get Function that receives name as an optional parameter and get all provinces matching the name if it is parsed
  // Otherwise, it gets all provinces in the model.
  @Operation.get()
  Future<Response> getAllProvinces({@Bind.query('name') String name}) async {

    final query = Query<Province>(context);

    if(name != null) {
      query.where((province) => province.name).contains(name, caseSensitive: false);
    }

    final res = await query.fetch();
    return Response.ok(res);
  }

  // This function is responsible for adding a new Province to the Database and accepts a JSON body
  @Operation.post()
  Future<Response> addProvince(@Bind.body(ignore: ['id']) Province province) async {

    final query = Query<Province>(context)
                    ..values.name = province.name
                    ..values.latitude = province.latitude
                    ..values.longitude = province.longitude
                    ..values.population = province.population;
    
    final insertedProvince = await query.insert();
    return Response.ok(insertedProvince);        
  }

  @Operation.delete()
  Future<Response> deleteProvince(@Bind.query('id') int id) async {
    final query = Query<Province>(context)
                    ..where((province) => province.id).equalTo(id);
    final provinceDeleted = await query.delete();

    if(provinceDeleted > 0) {
      return Response.ok({
         "status": "success",
         "message": "${provinceDeleted} record(s) successfully removed." 
      });
    } else if(provinceDeleted < 1) {
      return Response.notFound(body: {
        "status":"Failed",
        "message": "Could not find province with id ${id}."
      });
    }

    return Response.noContent();
  }
}