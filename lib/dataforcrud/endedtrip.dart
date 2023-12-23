import '../core/class/crud.dart';

import '../core/contants/api.dart';

class EndedTripData{
  Crud crud;
  EndedTripData(this.crud);
  getData(tripid)async{
    var response = await crud.getData(endtrip(tripid));
    return response.fold((left) => left, (right) => right);
  }

}