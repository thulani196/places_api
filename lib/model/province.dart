import 'package:aqueduct/aqueduct.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/town.dart';

class Province extends ManagedObject<_Province> implements _Province{}
class _Province {

  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  String longitude;
  String latitude;

  ManagedSet<Town> towns;
  
}