import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/tweet/services/tweet_services.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_text_field.dart';
import 'package:twitter_clone/widgets/ui_constants/assets_constants.dart';
import 'package:twitter_clone/widgets/ui_constants/create_tweet_app_bar.dart';
import 'package:twitter_clone/widgets/ui_constants/image_helper.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class CreateTweetScreen extends StatefulWidget {
  static const String routeName = '/create-tweet-screen';
  const CreateTweetScreen({super.key});

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {

  List<File> images = [];
  List<File> imageFiles = [];
  List<File> videos = [];

  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),

      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );



  @override
  Widget build(BuildContext context) {

    final user = context.watch<UserProvider>().user;
    final imageHelper = ImageHelper();
    List<File> imagesAA = [];
    String userProfilePic = user.profilePicture!;
    String defaultProfilePic = 'https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png';
    final TweetServices tweetServices = TweetServices();
    ImageProvider<Object> backgroundImageProvider;



    if (userProfilePic != '') {
      backgroundImageProvider = NetworkImage(userProfilePic);
    } else {
      backgroundImageProvider = AssetImage(AssetsConstants.noProfilePic);
    }

    final TextEditingController _tweetTextController = TextEditingController();
    final _createTweetKey = GlobalKey<FormState>();

    void pickTweetImages() async{

      final files = await imageHelper.pickImage(multiple: true);
      setState(() => imagesAA = files.map((e) => File(e.path)).toList());
      print("final list $imagesAA");


    }

    void selectImages() async{

      var res = await pickImages();

      setState(() {
        images = res;
      });
      print("final list $images");
    }

    void postMyTweet(){

      tweetServices.createATweet(
          context: context,
          onSuccess: (){
            Navigator.pop(context);
          },
          content: _tweetTextController.text,
          imageFile: images,
          videoFile: videos);


    }


    return Scaffold(
      appBar:
        CreateTweetAppBar(
        postTweet: () {
          postMyTweet();
      },
        tweetLength: _tweetTextController.text,
        postButtonName: 'Post',),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundImage: backgroundImageProvider,
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 3,),
                  CustomButton(
                    onClick: (){
                      print(imagesAA.length);
                      print(images.length);
                    },
                    buttonText: 'Public',
                    borderRadius: 19,
                    buttonColor: myColors.mainBackgroundColor,
                    textColor: Pallete.blueColor,
                    borderColor: Pallete.blueColor,
                    suffixIcon: true,
                    height: 30,
                    width: 8,

                    )
                ],
              ),
              Column(
                    children: [
                      TextField(
                            controller: _tweetTextController,
                            maxLines: null,
                            autofocus: true,
                            cursorColor: Pallete.blueColor,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white, // Set the text color here
                            ),
                            decoration: InputDecoration(
                              hintText: "   What's happening?",
                              hintStyle: TextStyle(
                                color: Pallete.postHintColor,
                                // fontWeight: FontWeight.w600
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                      SizedBox(height: 15,),

                      if(images.isNotEmpty)
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        children: images.asMap().entries.map((entry) {
                          final index = entry.key;
                          final imageFile = entry.value;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(imageFile.path)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: myColors.mainBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // Remove the image from the list when the close icon is tapped
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.close, color: myColors.whiteColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )

                    ],
                  ),

            ],
          ),
        ),
      ),
      bottomNavigationBar:
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Pallete.bottomBorderColor
              )
            )
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15),
                child: InkWell(
                    onTap: selectImages,
                    child: SvgPicture.asset(AssetsConstants.galleryIcon)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15),
                child: SvgPicture.asset(AssetsConstants.gifIcon),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15),
                child: Icon(Icons.poll_outlined,color: Pallete.blueColor,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(left: 15,right: 15),
                child: Icon(Icons.location_on_outlined,color: Pallete.blueColor,),
              )
            ],
          ),
        ),
      ),
    );




  }

  CarouselSlider CarouselImagePicker() {
    return CarouselSlider(
      items: images.map((i) {
        return Builder(
            builder: (BuildContext context) => Image.file(
              i,
              fit: BoxFit.cover,
              height: 200,
            ));
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }




}
