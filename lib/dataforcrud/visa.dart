import '../core/class/crud.dart';

import '../core/contants/api.dart';

class VisaData{
  Crud crud;
  VisaData(this.crud);
  getData()async{
    var response = await crud.getData(visaUrl.toString());
    return response.fold((left) => left, (right) => right);
  }

}