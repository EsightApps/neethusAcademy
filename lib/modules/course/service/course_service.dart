import 'package:http/http.dart';

import '../../../global/api_urls.dart';
import '../../../global/constants/interceptor.dart';

class CourseService{
  Future<Response> getWebApi() async{
      return await httpRequests(url: ApiUrls().getWeb , httpType: HttpMethods.get,headers: {
        'Content-Type' : 'application/json'
      });
      
    }
}