import 'package:digisina/features/blogs/domain/entity/blog_post.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlogPostView extends StatelessWidget {
  const BlogPostView({Key? key, required BlogPost post})
      : this.post = post,
        this.isDummy = false,
        super(key: key);

  const BlogPostView.dummy({Key? key})
      : this.post = null,
        this.isDummy = true,
        super(key: key);

  final BlogPost? post;
  final bool isDummy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (post == null) return;
        Navigator.of(context, rootNavigator: true)
            .pushNamed("/post", arguments: post);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: !isDummy
              ? [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 8.0,
                    spreadRadius: 0,
                  )
                ]
              : [],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: !isDummy
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: FittedBox(
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/place_holder.png",
                                image: post!.images[0],
                                fit: BoxFit.cover,
                                imageErrorBuilder: (_, __, ___) => Image.asset(
                                  "assets/place_holder.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 11,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post!.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        SizedBox(height: 4),
                        Text(
                          post!.description,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .apply(color: Color(0xFF5D5D5D)),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              post?.timeAgo ?? "",
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : SizedBox(height: 100),
      ),
    );
  }
}
