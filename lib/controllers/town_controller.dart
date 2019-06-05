import 'package:places_api/model/town.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class TownController extends ResourceController {
  
  TownController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllTowns({@Bind.query('name') String name}) async {

    final query = Query<Town>(context)..join(object: (p) => p.province);

    if(name != null) {
      query.where((t) => t.name).contains(name, caseSensitive: false);
    }

    final results = await query.fetch();
    return Response.ok(results);

  }

  @Operation.post()
  Future<Response> createTown(@Bind.body(ignore: ['id']) Town town) async {

      final provinceQuery = Query<Province>(context).where((province) => province.id).equalTo(town.province.id);
      final insertQuery = Query<Town>(context);

      if(provinceQuery == null ) {
        return Response.notFound(body: {
          "status": "Failed",
          "message": "Could not find specified Province."
        });
      }


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