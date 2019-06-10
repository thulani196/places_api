import 'package:aqueduct/aqueduct.dart';
import 'package:places_api/places_api.dart';
import 'package:places_api/model/province.dart';

class Town extends ManagedObject<_Town> implements _Town{}
class _Town {

  @primaryKey
  int id;

  @Column(nullable: false, unique: false)
  String name;

  @Column(nullable: true)
  String longitude;

  @Column(nullable: true)
  String latitude;

  @Column(nullable: false)
  int population;

  @Relate(#towns)
  Province province;

}