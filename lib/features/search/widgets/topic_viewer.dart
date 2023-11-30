import 'package:flutter/material.dart';
import 'package:twitter_clone/features/search/widgets/topic_card.dart';

import '../../../models/topics.dart';
import '../services/search_services.dart';

class TopicViewer extends StatefulWidget {
  final int tabNo;
  const TopicViewer({super.key, required this.tabNo});

  @override
  State<TopicViewer> createState() => _TopicViewerState();
}

class _TopicViewerState extends State<TopicViewer> {

  List<Topics>? allTopics = [];
  final SearchServices searchServices = SearchServices();


  fetchAllTopics() async {

    if(widget.tabNo==0) {
      allTopics = await searchServices.fetchForYouTopics(context: context);
    } else if(widget.tabNo==3){
      allTopics = await searchServices.fetchSportsTopics(context: context);

    }
    setState(() {});

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllTopics();
    });

    print('hola');

    //print(allFetchedTweets.toString());
  }

  @override
  Widget build(BuildContext context) {



    return Center(
      child: ListView.builder(
          itemCount: allTopics!.length,
          itemBuilder: (context,index) {
            if (index > 3 && index < 4) {
              return Container(
                height: 50, width: double.infinity, color: Colors.red,);
            } else {
              return TopicCard(topic: allTopics![index]);
            }
          }
      ),
    );
  }
}
