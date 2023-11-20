import '../../../../core/class/crud.dart';

import '../../../../core/contants/api.dart';

class DriverData{
  Crud crud;
  DriverData(this.crud);
  getData()async{
    var response = await crud.getData(profileUri);
    return response.fold((left) => left, (right) => right);
  }

  updateData(String name,String phone, age)async{
    var response = await crud.updateData(profileUpdateInfoUriHZ,
    {
      "name":name,
      "phone":phone,
      "age":age,
      //"email":email,
    });
    return response.fold((left) => left, (right) => right);
  }
}