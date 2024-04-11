import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tweet/features/tweet/bloc/tweet_bloc.dart';
import 'package:tweet/features/update_tweet/bloc/update_tweet_bloc.dart';

class UpdateTweet extends StatefulWidget {
  final TweetBloc tweetBloc;
  final String tweet;
  final String tweetId;
  const UpdateTweet({
    Key? key,
    required this.tweetBloc,
    required this.tweet,
    required this.tweetId,
  }) : super(key: key);

  @override
  State<UpdateTweet> createState() => _UpdateTweetState();
}

class _UpdateTweetState extends State<UpdateTweet> {
  TextEditingController contentController = TextEditingController();
  bool loader = false;

  UpdateTweetBloc updateTweetBloc = UpdateTweetBloc();
  @override
  void initState() {
    // TODO: implement initState
    contentController.text = widget.tweet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UpdateTweetBloc, UpdateTweetState>(
        bloc: updateTweetBloc,
        listenWhen: (previous, current) => current is UpdateTweetActionState,
        buildWhen: (previous, current) => current is! UpdateTweetActionState,
        listener: (context, state) {
          if (state is UpdateTweetLoadingState) {
            setState(() {
              loader = true;
            });
          } else if (state is UpdateTweetSuccessState) {
            widget.tweetBloc.add(CreateTweetInitialFetchEvent());
            setState(() {
              loader = false;
            });
            Navigator.pop(context);
          } else if (state is UpdateTweetErrorState) {
            setState(() {
              loader = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Something went wrong")));
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update Tweet",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: contentController,
                  maxLines: 30,
                  minLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write what in your mind 😊",
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 48,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          updateTweetBloc.add(UpdateTweetPostEvent(
                              content: contentController.text,
                              tweetId: widget.tweetId));
                        },
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )))
              ],
            ),
          );
        },
      ),
    );
  }
}
