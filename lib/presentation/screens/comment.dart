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
                      backgroundImage: imageProvider(data[i]['pic'])),
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

  ImageProvider imageProvider(String uri) {
    if (uri.startsWith('http') || uri.startsWith('https')) {
      return NetworkImage(uri);
    } else {
      return AssetImage(uri);
    }
  }

  void sendButtonMethod() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: commentChild(filedata),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            alignment: Alignment.bottomCenter,
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                fillColor: Colors.orange,
                filled: true,
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                    onPressed: () {
                      sendButtonMethod();
                    },
                    icon: const Icon(Icons.send)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
