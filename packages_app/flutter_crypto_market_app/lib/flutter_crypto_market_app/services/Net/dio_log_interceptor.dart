import 'package:ocean_common_module/ocean_common_module.dart';

///日志拦截器
class DioLogInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String requestStr = "\n==================== REQUEST ====================\n"
        "- URL:\n${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";

    requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

    final data = options.data;
    if (data != null) {
      if (data is Map) {
        requestStr += "- BODY:\n${data.mapToStructureString()}\n";
      } else if (data is FormData) {
        final formDataMap = {}
          ..addEntries(data.fields)
          ..addEntries(data.files);
        requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
      } else {
        requestStr += "- BODY:\n${data.toString()}\n";
      }
    }
    print(requestStr);
    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    String errorStr = "\n==================== RESPONSE ====================\n"
        "- URL:\n${err.requestOptions.baseUrl + err.requestOptions.path}\n"
        "- METHOD: ${err.requestOptions.method}\n";

    errorStr +=
        "- HEADER:\n${err.requestOptions.headers.mapToStructureString()}\n";
    if (err.response != null && err.response?.data != null) {
      print('╔ ${err.type.toString()}');
      errorStr += "- ERROR:\n${_parseResponse(err.response!)}\n";
    } else {
      errorStr += "- ERRORTYPE: ${err.type}\n";
      errorStr += "- MSG: ${err.message}\n";
    }
    print(errorStr);
    super.onError(err, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    String responseStr =
        "\n==================== RESPONSE ====================\n"
        "- URL:\n${response.requestOptions.uri}\n";
    responseStr += "- HEADER:\n{";
    response.requestOptions.headers
        .forEach((key, list) => responseStr += "\n  " "\"$key\" : \"$list\",");
    responseStr += "\n}\n";
    responseStr += "- STATUS: ${response.statusCode}\n";

    if (response.data != null) {
      responseStr += "- BODY:\n ${_parseResponse(response)}";
    }
    printWrapped(responseStr);
    super.onResponse(response, handler);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String _parseResponse(Response response) {
    String responseStr = "";
    var data = response.data;
    if (data is Map) {
      responseStr += data.mapToStructureString();
    } else if (data is List) {
      responseStr += data.listToStructureString();
    } else {
      responseStr += response.data.toString();
    }
    return responseStr;
  }
}

extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr"
              "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          result += "\n$indentationStr" "\"$key\" : \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      forEach((value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" "\"$temp\",";
        } else if (value is List) {
          result += value.listToStructureString(indentation: indentation + 2);
        } else {
          result += "\n$indentationStr" "\"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += "\n$indentationStr]";
    }

    return result;
  }
}
