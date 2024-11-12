
import 'package:flutter/material.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/home.dart';
import 'package:johndeereapp/services/local_storage.dart';
import 'package:johndeereapp/signup_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen ({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String? user='';
String psw='';
bool isChecked = false;

class _LoginScreenState extends State<LoginScreen> {
   final ctrlUser = TextEditingController();
   final ctrlPsw = TextEditingController();
  

  @override
  void initState(){
   
    super.initState();
  } // Practica 3
  
 
  @override
  void dispose() {
    ctrlUser.dispose();
    ctrlPsw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Login", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white
              ),),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/login.png', width: 230,)),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  child: TextField(
                    controller: ctrlUser,
                    
                    textAlignVertical: TextAlignVertical.center,
                    decoration:const  InputDecoration(
                      prefixIcon: Icon(Icons.email, color: btnColor,),
                      labelText: "Username",
                      border: InputBorder.none,
                    ),
                    
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  child:  TextField(
                    controller: ctrlPsw,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: btnColor,),
                      labelText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
        
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    const Text("¿Guardar sesión?",
                  ),
                  const SizedBox(width: 12,),
                  Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged:(bool? value) {
                        setState(() {
                          isChecked = value!;
                         });
                       },
                   )
                  ],
                ),
        
                const SizedBox(height: 12,),
                Container(
                  width: 400,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: btnColor
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if(isChecked){
                        LocalStorage.prefs.setString('user', ctrlUser.text);
                        LocalStorage.prefs.setString('email', ctrlUser.text);
                        LocalStorage.prefs.setString('psw', ctrlUser.text);
                         Navigator.push(context, MaterialPageRoute(builder: ((context)=>  Home())));
                        print("Okey preferenas");
                      }else{
                        
                      LocalStorage.prefs.remove('user');
                      LocalStorage.prefs.remove('psw');
                      Navigator.push(context, MaterialPageRoute(builder: ((context)=>  Home())));
                      print('reseteadas');
                      }
                      
                    },
                    child: const Text("Login",
                    style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,)),
                  )
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("Don't have a count?",),
                  const SizedBox(width: 12,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context)=> const SignupScreen())));
                    },
                    child: const Text("Signup",
                    style: TextStyle(
                      color: btnColor, fontWeight: FontWeight.bold
                    ),),
                  )
                  ],
                ),
                const SizedBox(height: 12,),
                const Row(
                  children: [
                    Expanded(child: Divider(
                      color: Colors.grey,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("OR", style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Expanded(child: Divider( color: Colors.grey))
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google.png', width: 30, height: 30),
                      const SizedBox(width: 20),
                      const Text("Continuar con Google", style: TextStyle(
                       fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/facebook.png', width: 30, height: 30),
                      const SizedBox(width: 20),
                      const Text("Continuar con Facebook", style: TextStyle(
                       fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  ),
                )
        
            ],
          ),
        ),
      ),
    );
  }
}