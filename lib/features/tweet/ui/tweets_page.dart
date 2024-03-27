import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweet/design/app_widgets.dart';
import 'package:tweet/features/create_tweet/ui/create_tweet.dart';
import 'package:tweet/features/tweet/bloc/tweet_bloc.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  TweetBloc tweetBloc = TweetBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTweet(),
                ));
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocConsumer<TweetBloc, TweetState>(
        bloc: tweetBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TweetSuccessState:
              final successState = state as TweetSuccessState;
              return Container(
                margin: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Center(child: AppLogoWidget()),
                    Expanded(
                        child: ListView.builder(
                      itemCount: successState.tweets.length,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ))
                  ],
                ),
              );
            case TweetLoadState:
              return Center(child: CircularProgressIndicator());
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
