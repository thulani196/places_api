import 'package:places_api/model/town.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class TownController extends ResourceController {
  
  TownController(this.context);
  final ManagedContext context;

  @Operation.post()
  Future<Response> createTown(@Bind.body(ignore: ['id']) Town town) async {

      final provinceQuery = Query<Province>(context);
      final insertQuery = Query<Town>(context);

      if( provinceQuery.where((province) => province.id).equalTo(town.province.id) == null ) {
        return Response.notFound(body: {
          "status": "Failed",
          "message": "Could not find specified Province."
        });
      }

      final province = provinceQuery.where((p) => p.id).equalTo(town.province.id);
      print("Province ${province}");

      // Assign Town Values from body params.
      insertQuery..values
        ..values.name = town.name
        ..values.longitude = town.longitude
        ..values.latitude = town.latitude
        ..values.population = town.population
        ..values.province.id = town.province.id;

      final insertedQuery = await insertQuery.insert();
      return Response.ok(insertedQuery);



  }

}