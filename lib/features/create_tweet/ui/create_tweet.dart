import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweet/features/create_tweet/bloc/create_tweet_bloc.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({super.key});

  @override
  State<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  TextEditingController contentController = TextEditingController();
  bool loader = false;

  CreateTweetBloc createTweetBloc = CreateTweetBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateTweetBloc, CreateTweetState>(
        bloc: createTweetBloc,
        listenWhen: (previous, current) => current is CreateTweetActionState,
        buildWhen: (previous, current) => current is! CreateTweetActionState,
        listener: (context, state) {
          if (state is CreateTweetLoadingState) {
            setState(() {
              loader = true;
            });
          } else if (state is CreateTweetSuccessState) {
            setState(() {
              loader = false;
            });
            Navigator.pop(context);
          } else if (state is CreateTweetErrorState) {
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
                  "Create Tweet",
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
                          createTweetBloc.add(CreateTweetPostEvent(
                              content: contentController.text));
                        },
                        child: Text(
                          "POST",
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
