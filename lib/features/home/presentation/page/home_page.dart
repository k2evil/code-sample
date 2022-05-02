import 'package:digisina/cores/widget/shimmer.dart';
import 'package:digisina/cores/widget/web_view.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:digisina/features/home/presentation/bloc/home_bloc.dart';
import 'package:digisina/features/home/presentation/bloc/home_states.dart';
import 'package:digisina/features/home/presentation/widget/blog_post.dart';
import 'package:digisina/features/home/presentation/widget/calendar.dart';
import 'package:digisina/features/home/presentation/widget/option.dart';
import 'package:digisina/features/home/presentation/widget/top_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<HomeCubit>(context);
    bloc.getHomePageComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: state is HomeLoaded
              ? buildHomeComponents(state)
              : Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  direction: ShimmerDirection.rtl,
                  child: buildHomeComponents(state),
                ),
        ),
      ),
    ));
  }

  Widget buildHomeComponents(HomeState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        HomeTopSlider(
          aspectRatio: 328.0 / 184.0,
          isLoading: state is! HomeLoaded,
          slides: state is HomeLoaded ? state.components.slides : null,
        ),
        SizedBox(
          height: 10,
        ),
        CalendarEvent(
          calendar: state is HomeLoaded ? state.components.dayInfo : null,
          isLoading: state is! HomeLoaded,
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: state is HomeLoaded
              ? Text(
                  "امکانات",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .apply(fontSizeFactor: 0.8),
                )
              : SizedBox(width: 64, child: DummyText(lines: 1)),
        ),
        SizedBox(height: 8.0),
        GridView.builder(
          padding: EdgeInsets.only(bottom: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 17.0,
            mainAxisSpacing: 17.0,
            childAspectRatio: 98 / 80,
          ),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state is HomeLoaded ? state.components.options.length : 6,
          itemBuilder: (context, index) {
            return OptionButton(
              onTap: handleOptionButtonClick,
              isLoading: state is! HomeLoaded,
              option:
                  state is HomeLoaded ? state.components.options[index] : null,
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: state is HomeLoaded
              ? Text(
                  "آخرین اخبار",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .apply(fontSizeFactor: 0.8),
                )
              : SizedBox(width: 64, child: DummyText(lines: 1)),
        ),
        SizedBox(
          height: 8.0,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state is HomeLoaded ? state.components.blogs.length : 2,
          itemBuilder: (context, index) {
            return state is HomeLoaded
                ? BlogPostView(
                    post: state.components.blogs[index],
                  )
                : BlogPostView.dummy();
          },
          separatorBuilder: (_, __) => SizedBox(height: 10),
        ),
        SizedBox(height: 50),
      ],
    );
  }

  void handleOptionButtonClick(HomePageOption option) {
    if (option.referenceType == "in_app")
      Navigator.of(context, rootNavigator: true)
          .pushNamed("/${option.reference}");
    else
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => WebViewWidget(
                title: option.title,
                link: option.reference,
                justLandscape: option.title == "پایش برنامه",
              )));
  }
}
