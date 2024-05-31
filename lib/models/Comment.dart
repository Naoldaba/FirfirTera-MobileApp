class Comment {
  final String? id;
  final String userId;
  final String comment;
  final String recipeId;

  Comment({
    this.id,
    required this.recipeId,
    required this.userId,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      comment: json['comment'],
      recipeId: json['recipeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'userId': userId,
      'comment': comment
    };
  }

}
