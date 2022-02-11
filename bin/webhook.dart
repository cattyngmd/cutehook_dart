import 'package:http/http.dart' as http;
import 'dart:convert';

class Webhook {

  static const headers = {'Content-Type': 'application/json'};

  late final Uri url;

  late final String username;

  late final String avataurl;

  late final String content;

  Webhook(this.url, this.username, this.avataurl, this.content);

  Future<http.Response> post() async {
    final body = json.encode({"content": content, "username": username});
    return await http.post(url, body: body, headers: headers);
  }

  Webhook.fromJson(Map<String, dynamic> json) {
    url = Uri.parse(json['url']);
    username = json['username'];
    content = json['content'];
    avataurl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['username'] = username;
    data['content'] = content;
    data['avatar_url'] = avataurl;
    return data;
  }

}