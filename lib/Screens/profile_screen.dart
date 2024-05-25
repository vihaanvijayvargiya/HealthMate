import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:health_mate/Screens/helth_main_screen.dart';
import 'package:health_mate/Screens/strembuilder.dart';
import 'package:health_mate/provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Widgets/input_text.dart';
import '../resources/auth_methos.dart';
import '../utils.dart';
import 'loginScreen.dart';



class ProfileScreen extends StatefulWidget {
  final name ;
  final email;
  const ProfileScreen({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.text =widget.name;
    _emailController.text = widget.email;
  }


  @override
  Widget build(BuildContext context) {
    dynamic profilesnap = context.watch<AppState>().firstSnapshot;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Profile',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600
        ),),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > 600
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.deepPurple),),
              SizedBox(height: 30,),
              _image != null
                  ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
                backgroundColor: Colors.white12,
              )
                  :  CircleAvatar(
                radius: 64,
                backgroundImage:NetworkImage('${profilesnap['profile']}',),
                backgroundColor: Colors.white12,
              ),
              const SizedBox(
                height: 24,
              ),
              InputText(
                hint: 'Enter your username',
                textInputType: TextInputType.text,
                controller: _usernameController,
                icon: Icon(Icons.person),
              ),
              const SizedBox(
                height: 24,
              ),
              InputText(
                hint: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                icon: Icon(Icons.email),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: (){
                  AuthMethods().signOut(context);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthScreen()), (route) => false);

                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: !_isLoading
                      ? const Text(
                    'Logout',style: TextStyle(fontSize: 20,color: Colors.white),
                  )
                      : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



}
