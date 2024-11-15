import 'package:http/http.dart';
import 'package:neethusacademy/global/api_urls.dart';
import 'package:neethusacademy/global/constants/interceptor.dart';

class LoginService {

    Future<Response> sendOtp(Object ? body) async{
      return await httpRequests(url: ApiUrls().login , httpType: HttpMethods.post,body: body );
      
    }
}