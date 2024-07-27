class Book {
  final int? id;
  final String title;
  final String author;
  final double rating;
  final bool isRead;
  // final string imagePath;
  final String content;
  final String? imagePath;
  final String? bookPath;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.rating = 0.0,
    this.isRead = false,
    //added
    required this.content,
    this.imagePath,
    this.bookPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
      //added
      'content': content,
      'imagePath': imagePath,
      'bookPath': bookPath,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      rating: map['rating'],
      isRead: map['isRead'] == 1,
      //added
      content: map['content'],
      imagePath: map['imagePath'],
      bookPath: map['bookPath'],
    );
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    double? rating,
    bool? isRead,
    //added
    String? content,
    String? imagePath,
    String? bookPath,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      isRead: isRead ?? this.isRead,
      //added
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      bookPath: bookPath ?? this.bookPath,
    );
  }
}
