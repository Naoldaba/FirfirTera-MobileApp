class Comment {
  final String? id;
  final Map<String, dynamic> user_inf;
  final String comment;
  final String recipeId;

  Comment({
    this.id,
    required this.recipeId,
    required this.user_inf,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      user_inf: Map<String, dynamic>.from(json['user_inf']),
      comment: json['text'],
      recipeId: json['recipeId'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'user_inf': user_inf,
      'comment': comment
    };
  }
}
