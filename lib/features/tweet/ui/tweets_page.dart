import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweet/design/app_widgets.dart';
import 'package:tweet/features/create_tweet/ui/create_tweet.dart';
import 'package:tweet/features/tweet/bloc/tweet_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tweet/features/update_tweet/ui/update_tweet.dart';

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
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

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
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    showDragHandle: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(8),
                                        height: height / 4.5,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Actions',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                print('Edit');
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateTweet(
                                                        tweetBloc: tweetBloc,
                                                        tweet: successState
                                                            .tweets[index]
                                                            .tweet
                                                            .content,
                                                        tweetId: successState
                                                            .tweets[index]
                                                            .tweet
                                                            .tweetId,
                                                      ),
                                                    ));
                                              },
                                              title: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              trailing: Icon(Icons.edit),
                                            ),
                                            SizedBox(
                                              height: height / 70,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                print('Delete');
                                                tweetBloc.add(DeleteTweetEvent(
                                                    tweetId: successState
                                                        .tweets[index]
                                                        .tweet
                                                        .tweetId));
                                                Navigator.pop(context);
                                              },
                                              title: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              trailing: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
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
