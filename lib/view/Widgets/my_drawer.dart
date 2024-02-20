import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../global/global_instances.dart';
import '../../global/global_vars.dart';
import '../Splash/splash_screen.dart';
import '../mainScreen/home_screen.dart';


class MyDrawer extends StatefulWidget {

  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          // header
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                // image
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(81)),
                  elevation: 8,
                  child: SizedBox(
                    height: 158,
                    width: 158,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        sharedPreferences!.getString('imageUrl').toString()
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Text(sharedPreferences!.getString('name').toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),)
                
              ],
            ),
          ),

          const SizedBox(height: 12,),

          Column(
            children: [

              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white,),
                title: const Text('Home',
                style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.reorder, color: Colors.white,),
                title: const Text('My Orders',
                  style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.access_time, color: Colors.white,),
                title: const Text('History',
                  style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.local_shipping, color: Colors.white,),
                title: const Text('Search Specific Restaurant',
                  style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.add_location, color: Colors.white,),
                title: const Text('Add New Address',
                  style: TextStyle(color: Colors.white),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                title: const Text('Sign Out',
                  style: TextStyle(color: Colors.white),),
                onTap: (){

                  FirebaseAuth.instance.signOut();

                  Navigator.push(context, MaterialPageRoute(builder: (_)=> SplashScreen()));
                },
              ),
              const Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
              ),

            ],
          )

        ],
      ),
    );
  }
}
