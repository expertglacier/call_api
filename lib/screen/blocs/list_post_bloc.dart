import 'dart:async';
import 'dart:convert';
import '../../models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeBloc {
  // ignore: unused_field
  final List<PostItem> _listPost = [];

  final StreamController<List<PostItem>> _listPostController =
      StreamController<List<PostItem>>();

  Stream<List<PostItem>> get listPostController => _listPostController.stream;

  void getListPost() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
      final response = await http.get(url);

      final json = jsonDecode(response.body) as List<dynamic>;
      // ignore: no_leading_underscores_for_local_identifiers
      final _listPost = json.map((e) => PostItem.fromJson(e)).toList();

      // await Future.delayed(const Duration(seconds: 5));

      _listPostController.sink.add(_listPost);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void dispose() {}
}
