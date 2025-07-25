import 'package:ocean_common_module/ocean_common_module.dart';

import 'result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestOptions option = response.requestOptions;
    ResultData? resultData;
    try {
      if (option.contentType != null && option.contentType!.contains("text")) {
        resultData = ResultData(response.data, true, 200);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["code"];
        if (code == 0) {
          resultData =
              ResultData(response.data, true, 200, headers: response.headers);
        } else {
          resultData =
              ResultData(response.data, false, 200, headers: response.headers);
        }
      }
    } catch (e) {
      print(e.toString() + option.path);
      resultData = ResultData(response.data, false, response.statusCode ?? 0,
          headers: response.headers);
    }
    if (resultData != null) {
      handler.next(Response(requestOptions: option, data: resultData));
    } else {
      handler.next(response);
    }
  }
}
