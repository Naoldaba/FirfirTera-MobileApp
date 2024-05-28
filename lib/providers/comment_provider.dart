import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_provider.g.dart';

@riverpod
class Comments extends _$Comments {
  @override
  List<Map<String, String>> build() {
    return [
      {
        'name': 'Chuks Okwuenu',
        'pic': 'https://picsum.photos/300/30',
        'message': 'I love to code',
        'date': '2021-01-01 12:00:00'
      },
      {
        'name': 'Biggi Man',
        'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
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
  }

  void addComment(String message) {
    state = [
      {
        'name': 'New User',
        'pic': 'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
        'message': message,
        'date': '2021-01-01 12:00:00'
      },
      ...state
    ];
  }
}
