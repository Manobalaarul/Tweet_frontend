import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweet/design/app_widgets.dart';
import 'package:tweet/features/create_tweet/ui/create_tweet.dart';
import 'package:tweet/features/tweet/bloc/tweet_bloc.dart';
import 'package:intl/intl.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  TweetBloc tweetBloc = TweetBloc();
  @override
  void initState() {
    tweetBloc.add(CreateTweetInitialFetchEvent());
    super.initState();
  }

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
                  builder: (context) => CreateTweet(
                    tweetBloc: tweetBloc,
                  ),
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
              return RefreshIndicator(
                onRefresh: () async {
                  tweetBloc.add(CreateTweetInitialFetchEvent());
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Center(child: AppLogoWidget()),
                      Expanded(
                          child: ListView.builder(
                        itemCount: successState.tweets.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  successState.tweets[index].tweet.content,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tweeted by : " +
                                          successState
                                              .tweets[index].admin.firstname +
                                          " " +
                                          successState
                                              .tweets[index].admin.lastname,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(DateFormat("dd MMMM yyyy hh:mm a")
                                        .format(successState
                                            .tweets[index].tweet.createdAt)),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ))
                    ],
                  ),
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
