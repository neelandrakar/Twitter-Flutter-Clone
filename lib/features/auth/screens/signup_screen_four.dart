import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/global_variables.dart';
import 'package:twitter_clone/constants/my_colors.dart';
import 'package:twitter_clone/features/auth/services/auth_services.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_button.dart';
import 'package:twitter_clone/widgets/custom_widgets/custom_text_field.dart';
import 'package:twitter_clone/widgets/ui_constants/mainAppBar.dart';

import '../../../constants/myTexts.dart';

class SignUpScreenFour extends StatefulWidget {
  static const String routeName = '/signup-screen-four';
  const SignUpScreenFour({super.key});

  @override
  State<SignUpScreenFour> createState() => _SignUpScreenFourState();
}

class _SignUpScreenFourState extends State<SignUpScreenFour> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final AuthServices authServices = AuthServices();

  void signUpUser(){

    if(isEmailSelected){

    authServices.signUp(
        context: context,
        name: signUpName,
        username: signUpUsername,
        email: signUpEmail,
        mobno: 0,
        password: signUpPassword,
        birthDate: signUpPassword);

    } else{
      authServices.signUp(
          context: context,
          name: signUpName,
          username: signUpUsername,
          email: '',
          mobno: signUpPhone,
          password: signUpPassword,
          birthDate: signUpbirthDate.toString());

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = signUpName;
    _usernameController.text = signUpUsername;
    _phoneController.text = signUpPhone.toString();
    _emailController.text = signUpEmail;
    _dateOfBirthController.text = signUpdateOfBirth;
    _passwordController.text = signUpPassword;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 30),
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 40),
              CustomTextField(
                controller: _nameController,
                hintText: 'Name',
                suffixIcons: Icon(Icons.check_circle_sharp,color: myColors.tickColor,size: 15),
                readOnly: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: _usernameController,
                hintText: 'Username',
                suffixIcons: Icon(Icons.check_circle_sharp,color: myColors.tickColor,size: 15),
                readOnly: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                  controller: isEmailSelected ? _emailController : _phoneController,
                  hintText: isEmailSelected ? 'Email' : 'Phone',
                  suffixIcons: Icon(Icons.check_circle_sharp,color: myColors.tickColor,size: 15),
                  readOnly: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: _dateOfBirthController,
                hintText: 'Date of birth',
                suffixIcons: Icon(Icons.check_circle_sharp,color: myColors.tickColor,size: 15),
                readOnly: true,
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: _obscureText,
                isPassword: true,
                suffixIconPassword: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,size: 18,),
                  color: myColors.greyColor,
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                readOnly: true,
              ),
              SizedBox(height: 50),
              Text(MyTexts.termsAndConditionsLong,
                style: TextStyle(
                    color: myColors.greyColor,
                    fontSize: 13
                ),),
              SizedBox(height: 20,),
              CustomButton(
                  onClick: (){
                   signUpUser();
                    //print(signUpbirthDate.toString());
                    //print(signUpdateOfBirth.toString());
                  },
                  buttonText: 'Sign Up',
                  borderRadius: 20,
                  width: double.infinity,
                  buttonColor: myColors.focusedBorderColorBlue,
                  textColor: myColors.whiteColor,
                  height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
