//'https://selivery.onrender.com/';
//'http://192.168.1.122:8000/';
const baseUri =
    'https://www.selivery-app.com/';
const authBaseUri = '${baseUri}auth/';
final driverLogin =
    Uri.parse('${authBaseUri}login/driver');
final driverRegister =
    Uri.parse('${authBaseUri}signup/driver');

final driversGoogleSignIn = Uri.parse('${authBaseUri}google/driver');

final verifyDriverEmailCodeUrl = Uri.parse('${authBaseUri}driver/verify_email');
final verifyClientResendEmailCodeUrl =
    Uri.parse('${authBaseUri}resend_verification_code');
//profile
final driverProfile = Uri.parse("${baseUri}user/profile");
final completeCarInfoUrl = Uri.parse('${baseUri}request');
final getAllAdsUri = Uri.parse('${baseUri}advertisement');
final sendNewPasswordUrl = Uri.parse('${baseUri}user/setPassword');
final sendForgetPasswordCodeUrl = Uri.parse('${authBaseUri}forget_password');
final reSendForgetPasswordCodeUrl =
    Uri.parse('${authBaseUri}resend_password_code');
final verifyClientForgetPasswordCodeUrl =
    Uri.parse('${authBaseUri}client/verify_password_code');
final verifyDriverForgetPasswordCodeUrl =
    Uri.parse('${authBaseUri}driver/verify_password_code');

final driverGoogleSignIn = Uri.parse('${authBaseUri}google/driver');
///////profile uri
const profileUri = '${baseUri}user/profile';
final profileUpdateImageUri = Uri.parse('${baseUri}user/changePicture');
final profileUpdateInfoUri = Uri.parse('${baseUri}user/updateInfo');
final profileClientUpdatePassword = Uri.parse('${baseUri}user/changePassword');
//categories

const String categoriesUrL = '${baseUri}category';
String CategoriesList(id) => "${baseUri}vehicles/sale/category/$id";
//getdata for owner sale car
String ownerData(id) => "${baseUri}user/owner/$id";

//trips
String endtrip(id) => "${baseUri}trip/$id/end_trip";
String rejecttrip(id) => "${baseUri}trip/$id/reject";
String arrivertoclient(id) =>
    "${baseUri}trip/$id/arrived_to_pickupLocation";

// add rent car
const String rentcar = '${baseUri}vehicles/rent';
String carsWithDriver(id) => "${baseUri}vehicles/rent/with_driver/category/$id";
String carsWithoutDriver(id) =>
    "${baseUri}vehicles/rent/without_driver/category/$id";
const String addCarForSale = "${baseUri}vehicles/sale";
const String getrequesttrips =
    "${baseUri}trip/get_driver_requests";
String accepttrips(id) => "${baseUri}trip/$id/accept";
const String mytrips = "${baseUri}driver/trips";

//payments

final visaUrl =
    Uri.parse("${baseUri}payments/card_payment");
final CashUrl =
    Uri.parse("${baseUri}payments/wallet_payment");

/////////
final authHeaders = {
  'Keep-Alive': 'timeout=5',
  'Connection': 'keep-alive',
  'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
  'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
  'Content-Type': 'application/json; charset=utf-8',
  'X-Powered-By': 'Express',
  'Access-Control-Allow-Origin': '*',
};
authHeadersWithToken(String token) => {
      'Keep-Alive': 'timeout=5',
      'Connection': 'keep-alive',
      'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
      'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
      'Content-Type': 'application/json; charset=utf-8',
      'X-Powered-By': 'Express',
      'Access-Control-Allow-Origin': '*',
      'AUTHORIZATION': 'Bearer $token',
    };

authHeadersWithTokenIm(String token) => {
      'Keep-Alive': 'timeout=5',
      'Connection': 'keep-alive',
      'Date': 'Fri, 18 Aug 2023 21:32:41 GMT',
      'ETag': 'W/"260-WWE610PoFt4+PMlb4uXuYqzj+4w"',
      'Content-Type':
          'multipart/form-data; boundary=<calculated when request is sent>',
      'X-Powered-By': 'Express',
      'Access-Control-Allow-Origin': '*',
      'Authorization': 'Bearer $token',
    };
