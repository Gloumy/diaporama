class Post {
  final String title;
  final String url;
  final String thumbnailUrl;
  final String domain;

  Post({
    this.title,
    this.url,
    this.thumbnailUrl,
    this.domain,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnail"],
        domain: json["domain"],
      );
}
