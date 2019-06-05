import 'package:aqueduct/aqueduct.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/town.dart';

class Province extends ManagedObject<_Province> implements _Province{}
class _Province {

  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  @Column(nullable: true)
  String longitude;
  
  @Column(nullable: true)
  String latitude;

  @Column(nullable: true)
  BigInt population;


  ManagedSet<Town> towns;
  
}