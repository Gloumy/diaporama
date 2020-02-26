import 'package:diaporama/models/post.dart';
import 'package:diaporama/utils/http_client.dart';
import 'package:dio/dio.dart';

class PostsRepository {
  Future<List<Post>> retrievePosts(String subreddit) async {
    Response response = await HttpClient.dio.get("$subreddit.json");
    List<dynamic> responseData = response.data["data"]["children"];
    List<Post> posts = [];
    responseData.forEach((p) => posts.add(Post.fromJson(p["data"])));

    return posts;
  }
}
