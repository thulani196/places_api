import 'package:places_api/places_api.dart';
import 'controllers/province_controller.dart';
import 'controllers/town_controller.dart';

class PlacesApiChannel extends ApplicationChannel {

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/api/provinces/[:id]")
      .link(() => ProvinceController());

    router
      .route("/api/towns/[:id]")
      .link(() => TownController());

    router
      .route("/api/register")
      .linkFunction((request) async {
        return Response.ok({'message': 'You have reached the register endpoint'});
      });

    return router;
  }
}