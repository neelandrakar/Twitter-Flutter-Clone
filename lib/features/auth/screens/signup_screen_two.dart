import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen_three.dart';
import 'package:twitter_clone/features/auth/services/auth_services.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_text_field.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';
import 'package:intl/intl.dart';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_widgets/custom_button.dart';




class SignUpScreenTwo extends StatefulWidget {
  static const String routeName = '/signup-screen-two';
  const SignUpScreenTwo({super.key});

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signUpFormKeyOne = GlobalKey<FormState>();
  Color nextButtonColor = myColors.greyColor;
  String useEmailPhoneButton = 'Use email instead';
  String usePhoneInstead = 'Use phone instead';
  String phoneEmailText = 'Phone no';
  String emailText = 'Email';

  final AuthServices authServices = AuthServices();

  void checkExistingUser(){

    if(isEmailSelected){
      authServices.checkExistingUser(
          context: context,
          emailAddress: _emailController.text,
          username: _usernameController.text,
          nextPage: navigateToSignUpThreePage);
    } else{
      authServices.checkExistingUser(
          context: context,
          mobno: int.parse(_phoneController.text),
          username: _usernameController.text,
          nextPage: navigateToSignUpThreePage);
    }
  }

  void navigateToSignUpThreePage(){
    Navigator.pushNamed(context, SignUpScreenThree.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      signUpbirthDate = DateTime.now();

    });

  }



  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system
            // navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            // Provide a background color for the popup.
            color: Colors.white,
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Create your account',
                  style: TextStyle(
                      color: myColors.whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700
                  ),
                ),

              ),
              SizedBox(height: 70,),
              Center(
                //alignment: Alignment.center,
                child: Form(
                  key: _signUpFormKeyOne,
                  child: Column(
                    children: [
                      CustomTextField(controller: _nameController, hintText: 'Name'),
                      SizedBox(height: 20),
                      CustomTextField(controller: _usernameController, hintText: 'Username'),
                      SizedBox(height: 20),
                      CustomTextField(
                          controller: isEmailSelected ? _emailController : _phoneController,
                          hintText: phoneEmailText),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _dateOfBirthController,
                        readOnly: true,
                        hintText: 'Date of birth',onClick: (){
                        _showDialog(
                          CupertinoDatePicker(

                            initialDateTime: signUpbirthDate,
                            dateOrder: DatePickerDateOrder.dmy,
                            maximumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            // This shows day of week alongside day of month
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                signUpbirthDate = newDate;
                                _dateOfBirthController.text = DateFormat('MMMM d, y').format(signUpbirthDate);
                              });
                            },
                          ),
                        );
                      },),
                      SizedBox(height: 20),
                      CustomTextField(controller: _passwordController, hintText: 'Password',isPassword: true,),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 150),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onClick: () {
                        print(isEmailSelected);
                        print('Email con text ${_emailController.text}');
                        print('Phone con text ${_phoneController.text}');
                        setState(() {
                          if(!isEmailSelected){
                            isEmailSelected = true;
                            phoneEmailText = 'Email';
                            useEmailPhoneButton = 'Use phone instead';
                            _phoneController.text = '';
                          } else{
                            isEmailSelected = false;
                            phoneEmailText = 'Phone';
                            useEmailPhoneButton = 'Use email instead';
                            _emailController.text = '';
                          }

                        });
                      },
                      buttonText: useEmailPhoneButton,
                      height: 30,
                      width: 30,
                      borderRadius: 20,
                      borderColor: myColors.whiteColor,
                      textColor: myColors.whiteColor,
                      buttonColor: myColors.mainBackgroundColor,
                    ),
                    CustomButton(
                      onClick: () {
                        if(_signUpFormKeyOne.currentState!.validate()){
                          signUpName = _nameController.text;
                          signUpUsername = _usernameController.text;
                          signUpPassword = _passwordController.text;
                          signUpdateOfBirth = _dateOfBirthController.text;
                          if(isEmailSelected){
                            signUpEmail = _emailController.text;
                            signUpPhone = 0;
                          } else{
                            signUpPhone = int.parse(_phoneController.text);
                            signUpEmail = '';
                          }
                          //print(signUpEmail);
                          //print(signUpPhone);
                          checkExistingUser();
                        }
                      },
                      buttonText: 'Next',
                      height: 30,
                      width: 30,
                      borderRadius: 20,
                      buttonColor: nextButtonColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
