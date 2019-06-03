import 'package:aqueduct/aqueduct.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class Town extends ManagedObject<_Town> implements _Town{}
class _Town {

  @primaryKey
  int id;

  String name;
  String longitude;
  String latitude;


  @Relate(#towns)
  Province province;

}