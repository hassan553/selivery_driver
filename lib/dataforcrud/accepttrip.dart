import '../core/class/crud.dart';

import '../core/contants/api.dart';

class AcceptTripData{
  Crud crud;
  AcceptTripData(this.crud);
  getData(tripid)async{
    var response = await crud.getData(accepttrips(tripid));
    return response.fold((left) => left, (right) => right);
  }

}