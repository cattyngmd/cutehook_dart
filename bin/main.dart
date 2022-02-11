import 'dart:io';
import 'dart:convert';
import 'webhook.dart';

void main(List<String> arguments) async {

  if (arguments.length != 1) exit(1);

  print("CuteHook (dart)");

  String content = File(arguments[0]).readAsStringSync();

  var jsonContent = json.decode(content);
  int delay = jsonContent["delay"];
  var hook = Webhook.fromJson(jsonContent);

  while (true) {
    final status = await hook.post();
    switch (status.statusCode) {

      case 404: {
        print("Not Found");
      }
      break;

      case 204: {
        print("Good");
      }
      break;

      case 429: {
        var body = json.decode(status.body);
        print("Retry after ${body["retry_after"]}");
        sleep(Duration(milliseconds: body["retry_after"]));
      }
      break;

      default: {
        print(status.statusCode);
      }

    }
    if(delay != 0) sleep(Duration(milliseconds: delay));
  }
}
