import 'package:places_api/places_api.dart';
import 'controllers/province_controller.dart';
import 'controllers/town_controller.dart';

class PlacesApiChannel extends ApplicationChannel {

  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = PlacesConfig(options.configurationFilePath.toString()); 
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username, 
      config.database.password, 
      config.database.host, 
      config.database.port, 
      config.database.databaseName
    );

    context = ManagedContext(dataModel, persistentStore);

  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/api/provinces/[:id]")
      .link(() => ProvinceController(context));

    router
      .route("/api/towns/[:id]")
      .link(() => TownController(context));

    router
      .route("/api/register")
      .linkFunction((request) async {
        return Response.ok({'message': 'You have reached the register endpoint'});
      });

    return router;
  }
}

class PlacesConfig extends Configuration {
  PlacesConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}