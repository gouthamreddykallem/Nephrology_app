class Quiz{
  const Quiz({
    required this.id,
    required this.title,
    required this.description,
  });

  final String id;
  final String title;
  final String description;

  static const none = Quiz(
    id: '',
    title: '',
    description: '',
  );

  List<Object?> get props => [id, title, description];
}

class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.imageName,
    required this.quizzes,
  });

  final String id;
  final String title;
  final String description;
  final String imageName;
  final List<Quiz> quizzes;

  static const none = Topic(
    id: '',
    title: '',
    description: '',
    imageName: '',
    quizzes: [],
  );

  List<Object?> get props => [id, title, description, imageName, quizzes];

}

extension TopicExtensions on Topic {
  bool get isNone => this == Topic.none;
  bool get isNotNone => !isNone;

  int get totalQuizzes => quizzes.length;

  double completedProgress(int completedQuizzes) {
    if (totalQuizzes == 0) {
      return 0;
    }
    return completedQuizzes / totalQuizzes;
  }

  String progress(int completedQuizzes) {
    return '$completedQuizzes / $totalQuizzes';
  }
}