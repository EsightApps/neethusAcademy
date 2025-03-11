import 'package:NeethusApp/global/constants/interceptor.dart';
import 'package:http/http.dart';

import '../../../global/api_urls.dart';

class LoginService {

    Future<Response> sendOtp(Object ? body) async{
      return await httpRequests(url: ApiUrls().login , httpType: HttpMethods.post,body: body );
      
    }
}