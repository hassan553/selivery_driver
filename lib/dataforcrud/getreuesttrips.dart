import '../core/class/crud.dart';

import '../core/contants/api.dart';

class RequestTripsData{
  Crud crud;
  RequestTripsData(this.crud);
  getData()async{
    var response = await crud.getData(getrequesttrips);
    return response.fold((left) => left, (right) => right);
  }

}