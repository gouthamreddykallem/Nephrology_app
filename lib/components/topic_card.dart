import 'package:flutter/material.dart';
import 'package:nephrology_app/components/animated_progress_bar.dart';
import 'package:nephrology_app/pages/topic_page.dart';
import 'package:nephrology_app/shared/topic.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({required this.topic, super.key});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.id,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TopicPage(
                  topic: topic,
                );
              },
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(topic.imageName),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          topic.title,
                          style: const TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TopicProgress(
                  topic: topic,
                  quizCount: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({
    required this.topic,
    required this.quizCount,
    super.key,
  });

  final Topic topic;
  final int quizCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(
          topic.progress(quizCount),
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Expanded(
          child: AnimatedProgressBar.mini(
            value: topic.completedProgress(quizCount),
          ),
        ),
      ],
    );
  }
}
