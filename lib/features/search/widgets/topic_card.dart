import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/features/search/services/search_services.dart';
import 'package:twitter_clone/models/topics.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TopicCard extends StatefulWidget {
  final Topics topic;
  const TopicCard({super.key, required this.topic});

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  Widget build(BuildContext context) {

    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      locale: 'en_IN',
      symbol: '',
    ).format(widget.topic.count);

    var _formattedCount = NumberFormat.compact().format(widget.topic.count);


    return InkWell(
      onTap: (){},
      child: Container(
        height: 90,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.topic.header,
                    style: TextStyle(
                      color: Pallete.postHintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),),
                  SizedBox(height: 5,),
                  Text(widget.topic.details,
                    style: TextStyle(
                        color: Pallete.whiteColorSecond,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  SizedBox(height: 5,),
                  Text('${_formattedCount.toString()} posts',
                    style: TextStyle(
                        color: Pallete.postHintColor,
                        fontSize: 16
                    ),),
                ],
              ),
              Icon(Icons.more_vert_outlined,color: Pallete.whiteColorSecond,size: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
