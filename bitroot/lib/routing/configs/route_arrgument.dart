import 'dart:convert';



//-------------------------------------------------------------------------------------------------------------------//

CommonScreenArgument addCommonScreenArgumentFromMap(String str) =>
    CommonScreenArgument.fromMap(json.decode(str));

String addCommonScreenArgumentToMap(CommonScreenArgument data) =>
    json.encode(data.toMap());

class CommonScreenArgument {
  CommonScreenArgument({
    required this.memberId,
  });

  var memberId;

  factory CommonScreenArgument.fromMap(Map<String, dynamic> json) =>
      CommonScreenArgument(
        memberId: json["memberId"],
      );

  Map<String, dynamic> toMap() =>
      {
        "memberId": memberId,
      };

  static String addCommonArgument({memberId}) {
    Map<String, dynamic> map = {
      'memberId': memberId,
    };
    return json.encode(map);
  }
}
