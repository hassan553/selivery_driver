import '../core/class/crud.dart';

import '../core/contants/api.dart';

class ArrivedToClientData{
  Crud crud;
  ArrivedToClientData(this.crud);
  getData(tripid)async{
    var response = await crud.getData(arrivertoclient(tripid));
    return response.fold((left) => left, (right) => right);
  }

}