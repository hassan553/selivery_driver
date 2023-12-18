import '../core/class/crud.dart';

import '../core/contants/api.dart';

class MyTripsData{
  Crud crud;
  MyTripsData(this.crud);
  getData()async{
    var response = await crud.getData(mytrips);
    return response.fold((left) => left, (right) => right);
  }

}