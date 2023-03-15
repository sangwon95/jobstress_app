
class RestResponse {

  Map<String, dynamic> data;
  List<dynamic> answers;

  RestResponse({this.data, this.answers});

  factory RestResponse.fromJson(Map<String, dynamic> json) {
    return new RestResponse(
        data     : json['data'] as Map,
        answers  : json['data']['answers'] as List<dynamic>
    );
  }
}

class ResultRestResponse { // 결과 리스트
  Map<String, dynamic> status;
  List<dynamic> data;

  ResultRestResponse({this.status, this.data});

  factory ResultRestResponse.fromJson(Map<String, dynamic> json) {
    return new ResultRestResponse(
        status: json['status'] as Map,
        data: json['data'] as List<dynamic>
    );
  }
}

/// 상세 내용
class RestResponseDataMap {
  Map<String, dynamic> status;
  Map<String, dynamic> data;

  RestResponseDataMap({this.status, this.data});

  factory RestResponseDataMap.fromJson(Map<String, dynamic> json) {
    return new RestResponseDataMap(
        status: json['status'] as Map,
        data: json['data'] as Map
    );
  }
}