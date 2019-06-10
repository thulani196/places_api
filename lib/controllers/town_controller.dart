import 'package:places_api/model/town.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class TownController extends ResourceController {
  
  TownController(this.context);
  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getById({@Bind.query('id') int id}) async {
    final query = Query<Town>(context)..where((town) => town.id).equalTo(id);
    final result = await query.fetchOne();

    if(result == null) {
      return Response.notFound(body: {
        "status": "Failed",
        "message": "Could not find Town with id: ${id}"
      });
    }

    return Response.ok(result);
  }

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

  @Operation.delete('id')
  Future<Response> deleteById(@Bind.query('id') int id) async {
    final record = Query<Town>(context)..where((t) => t.id).equalTo(id);
    final toDelete = await record.delete();

    if(toDelete > 0) {

      return Response.ok({
         "status": "success",
         "message": "${toDelete} record(s) successfully removed." 
      });

    } else if(toDelete < 1) {

      return Response.notFound(body: {
        "status":"Failed",
        "message": "Could not find town with id ${id}."
      });

    }

    return Response.noContent();
  }

}