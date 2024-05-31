class Comment {
  final String? id;
  final String userId;
  final String text;
  final String recipeId;

  Comment({
    this.id,
    required this.recipeId,
    required this.userId,
    required this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      userId: json['userId']['_id'],
      text: json['text'],
      recipeId: json['recipeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'userId': userId,
      'text': text
    };
  }
}
