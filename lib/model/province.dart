import 'package:aqueduct/aqueduct.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/town.dart';

class Province extends ManagedObject<_Province> implements _Province{}
class _Province {

  @primaryKey
  int id;

  @Column(unique: true, nullable: false)
  String name;

  @Column(nullable: true)
  String longitude;

  @Column(nullable: true)
  String latitude;

  @Column(nullable: false)
  int population;

  ManagedSet<Town> towns;
  
}