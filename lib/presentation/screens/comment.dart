// import 'package:firfir_tera/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:firfir_tera/providers/comment_provider.dart";
import 'package:firfir_tera/models/User.dart';

class CreateComment extends ConsumerStatefulWidget {
  const CreateComment({super.key});

  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends ConsumerState<CreateComment> {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Image.network(imageUrl),
          ),
        );
      },
    );
  }

  Widget commentChild(List<Map<String, String>> data) {
    return ListView(
      controller: _scrollController,
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  showImageDialog(context, data[i]['pic']!);
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imageProvider(data[i]['pic']!),
                  ),
                ),
              ),
              title: Text(
                data[i]['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']!),
              trailing:
                  Text(data[i]['date']!, style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  ImageProvider imageProvider(String uri) {
    if (uri.startsWith('http') || uri.startsWith('https')) {
      return NetworkImage(uri);
    } else {
      return AssetImage(uri);
    }
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Comment cannot be blank'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void sendButtonMethod() {
    if (!formKey.currentState!.validate()) {
      showErrorDialog(context);
    } else {
      ref.read(commentsProvider.notifier).addComment(commentController.text);
      commentController.clear();
      FocusScope.of(context).unfocus();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider);
    // final User user = ref.read(userStateProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: commentChild(comments),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            alignment: Alignment.bottomCenter,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  fillColor: Colors.orange,
                  filled: true,
                  hintText: 'Add a comment...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: sendButtonMethod,
                    icon: const Icon(Icons.send),
                  ),
                ),
                validator: (value) => value!.isEmpty ? '' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
