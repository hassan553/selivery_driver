import '../core/class/crud.dart';

import '../core/contants/api.dart';

class RejectTripData{
  Crud crud;
  RejectTripData(this.crud);
  getData(tripid)async{
    var response = await crud.getData(rejecttrip(tripid));
    return response.fold((left) => left, (right) => right);
  }

}