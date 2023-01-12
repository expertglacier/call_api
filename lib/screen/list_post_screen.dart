import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'blocs/list_post_bloc.dart';

class MyAppState extends StatefulWidget {
  const MyAppState({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppState> {
  bool imageReady = false;
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.getListPost();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn API'),
      ),
      body: StreamBuilder<List<PostItem>>(
        stream: _homeBloc.listPostController,
        builder: (context, snapshot) {
          final listPost = snapshot.data;

          if (listPost == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (listPost.isEmpty) {
            return const Center(
              child: Text('Không có data.'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final item = listPost[index];

              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: item.thumbnailUrl != null
                    ? Image.network(item.thumbnailUrl!, errorBuilder: (context, error, stackTrace) {
                      return Container();
                    },)
                    : const SizedBox(),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: listPost.length,
          );
        },
      ),
    );
  }
}
