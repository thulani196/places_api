import 'package:aqueduct/managed_auth.dart';
import 'package:places_api/places_api.dart';
import 'controllers/province_controller.dart';
import 'controllers/register_controller.dart';
import 'controllers/town_controller.dart';
import 'model/user.dart';

class PlacesApiChannel extends ApplicationChannel {

  ManagedContext context;
  AuthServer authServer;

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

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/api/token")
      .link(() => AuthController(authServer));

    router
      .route("/api/provinces/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => ProvinceController(context));

    router
      .route("/api/towns/[:id]")
      .link(() => Authorizer.bearer(authServer))
      .link(() => TownController(context));

    router
      .route("/api/register")
      .link(() => RegisterController(context, authServer));

    return router;
  }
}

class PlacesConfig extends Configuration {
  PlacesConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}
