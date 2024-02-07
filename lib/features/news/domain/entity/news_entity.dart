import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String newsid;
  final String title;
  final String nimage;
  final String content;
  final String date;
  final String writer;

  const NewsEntity({
    required this.newsid,
    required this.title,
    required this.nimage,
    required this.content,
    required this.date,
    required this.writer,
  });

  factory NewsEntity.fromJson(Map<String, dynamic> json) => NewsEntity(
        newsid: json["newsid"],
        title: json["title"],
        nimage: json["nimage"],
        content: json["content"],
        date: json["date"],
        writer: json["writer"],
      );

  Map<String, dynamic> toJson() => {
        "newsid": newsid,
        "title": title,
        "nimage": nimage,
        "content": content,
        "date": date,
        "writer": writer,
      };

  @override
  List<Object?> get props => [newsid, title, nimage, content, date, writer];
}
