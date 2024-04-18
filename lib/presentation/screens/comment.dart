import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({super.key});

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List filedata = [];

  @override
  void initState() {
    filedata = [
      {
        'name': 'Chuks Okwuenu',
        'pic': 'https://picsum.photos/300/30',
        'message': 'I love to code',
        'date': '2021-01-01 12:00:00'
      },
      {
        'name': 'Biggi Man',
        'pic':
            'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
        'message': 'Very cool',
        'date': '2021-01-01 12:00:00'
      },
      {
        'name': 'Tunde Martins',
        'pic': 'assets/images/kikil.jpg',
        'message': 'Very cool',
        'date': '2021-01-01 12:00:00'
      },
      {
        'name': 'Biggi Man',
        'pic': 'https://picsum.photos/300/30',
        'message': 'Very cool',
        'date': '2021-01-01 12:00:00'
      },
    ];
    super.initState();
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing:
                  Text(data[i]['date'], style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Comment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: CommentBox(
                userImage: CommentBox.commentImageParser(
                    imageURLorPath: "assets/images/kikil.jpg"),
                child: commentChild(filedata),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    setState(() {
                      var value = {
                        'name': 'New User',
                        'pic':
                            'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                        'message': commentController.text,
                        'date': '2021-01-01 12:00:00'
                      };
                      filedata.insert(0, value);
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.pink,
                textColor: Colors.white,
                sendWidget:
                    Icon(Icons.send_sharp, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
