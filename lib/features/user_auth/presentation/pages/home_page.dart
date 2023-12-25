import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_projet/features/user_auth/presentation/pages/event_card.dart';
import 'package:event_projet/features/user_auth/presentation/pages/liste_event.dart';
import 'package:event_projet/features/user_auth/presentation/pages/view_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection("EventBase").snapshots();
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 249, 240, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 221, 158, 220),
          automaticallyImplyLeading: false,
          title: const Text("HomePage"),
          actions:[
            IconButton(icon: const Icon(Icons.logout),
             onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
            )
          ]
        ), 

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(221, 221, 158, 220),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32, 
                color: Colors.white,
                ),
                //title:Container(),
                label: "",
              ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: (){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (builder)=>const ListEventPage()));
                },
                child: CircleAvatar(
                  radius:24,
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 140, 226, 225),
                                Color.fromARGB(255, 187, 120, 199),
                              ],
                              ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 29, 
                            color: Colors.white,
                            ),
                          )),
                          ),
                          label: "",
                          //title:Container(),
                          ),
 
               const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32, 
                color: Colors.white,
                ),
                //title:Container(),
                label: "",
              ),
              ],
              ),

          body: StreamBuilder(
            stream: _stream,
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context,index){
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document = 
                  snapshot.data?.docs[index].data() as Map<String,dynamic>;
                  switch(document["Category"]){
                    case "work":
                      iconData = Icons.run_circle_outlined;
                      iconColor = const Color.fromARGB(255, 113, 116, 116);
                      break;
                    case "workout":
                      iconData = Icons.alarm;
                      iconColor = const Color.fromARGB(255, 113, 116, 116);
                      break;
                    case "Food":
                      iconData = Icons.food_bank;
                      iconColor = const Color.fromARGB(255, 113, 116, 116);
                      break;
                    case "Design":
                      iconData = Icons.audiotrack;
                      iconColor = const Color.fromARGB(255, 113, 116, 116);
                      break;
                    default:
                      iconData = Icons.run_circle_outlined;
                      iconColor = const Color.fromARGB(255, 113, 116, 116);
                  }
                  selected.add(Select(
                    //id:snapshot.data?.docs[index].id,
                    id: snapshot.data?.docs[index].id ?? "",
                    checkValue: false));
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                      MaterialPageRoute(builder: (builder)=> ViewData(
                        document : document,
                        id: snapshot.data?.docs[index].id ?? "",
                        //id : snapshot.data?.docs[index].id,
                      ),
                      ),
                      );
                    },
                  child:EventCard(
                            title: document["title"] ?? "hey there",
                            check: selected[index].checkValue,
                            iconBgColor: Colors.white,
                            iconColor: iconColor,
                            iconData: iconData,
                            time: "10 Am",
                            index: index,
                            onChange: onChange,
                          ),
                        );
                      },
                      );
                  }
              ),
            );
        }
  void onChange(int index){
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }

}

class Select{
  String id;
  bool checkValue = false;
  Select({required this.id,required this.checkValue});
}
