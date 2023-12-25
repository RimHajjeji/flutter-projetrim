import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListEventPage extends StatefulWidget{
  
  const ListEventPage({super.key});
  @override
  _ListEventPagestate createState()=>  _ListEventPagestate();
}
class _ListEventPagestate extends State<ListEventPage>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff1d1e26),
       body:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 164, 238, 234),
                  Color.fromARGB(255, 209, 243, 241),
                  ],),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                    ),),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                          letterSpacing: 4, 
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "New event",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                          shadows: [Shadow()],
                          letterSpacing: 2, 
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      label("Event Name"),
                      const SizedBox(
                        height: 12,
                      ),
                      title(),
                      const SizedBox(
                        height: 30,
                      ),
                      label("Event Type"),
                      const SizedBox(
                        height: 12,
                      ),
                     Row(
                      children:[
                        taskSelect("Important", 0xff2664fa),
                        const SizedBox(
                          width: 20,
                        ),
                        taskSelect("Planned", 0xff2bc8d9),
                
                      ],
                    ),

                        const SizedBox(
                          height: 25,
                        ),
                        label("Description"),
                        const SizedBox(
                            height: 12,
                          ),
                          description(),
                          const SizedBox(
                              height: 25,
                            ),
                            label("Category"),
                            const SizedBox(
                                height: 12,
                              ),
                            Wrap(
                            runSpacing: 10,
                            children:[
                              categorySelect("Food",0xffff6d6e),
                                const SizedBox(
                                  width: 20,
                                ),
                              categorySelect("Workout",0xfff29732),
                              const SizedBox(
                                  width: 20,
                                ),
                                categorySelect("Work",0xff6557ff),
                                const SizedBox(
                                  width: 20,
                                ),
                                categorySelect("Design",0xff234ebd),
                                const SizedBox(
                                  width: 20,
                                ),
                                categorySelect("Run",0xff2bc8d9),
                                ],
                              ),
                                const SizedBox(
                                        height: 50,
                                      ),
                                      button(),
                                      const SizedBox(
                                        height: 30,
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

                  Widget button(){
                    return InkWell(
                    onTap: (){
                      FirebaseFirestore.instance.collection("EventBase").add({
                        "title": _titleController.text,
                        "task": type,
                        "Category": category,
                        "description": _descriptionController.text,
                      });
                      Navigator.pop(context);
                    },
                    child:Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width - 80,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 180, 107, 177),
                            Color.fromARGB(255, 177, 143, 210),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Add event",
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                        ),
                    ),
                    );
                  }

                  Widget label(String label){
                    return Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:FontWeight.w600,
                        fontSize: 16.5,
                        letterSpacing: 0.2, 
                        ),
                      );
                    }

                  Widget taskSelect(String label, int color) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              type = label;
                            });
                          },
                        child:Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: type==label? Colors.white : Color(color),
                          label: Text(label), 
                            labelStyle: TextStyle( 
                              color: type==label? Colors.black : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 3.8,
                          ),
                        ),
                        );
                      }

                       Widget categorySelect(String label, int color) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              category = label;
                            });
                          },
                        child:Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: category==label? Colors.white : Color(color),
                          label: Text(label), 
                            labelStyle: TextStyle( 
                              color: category==label? Colors.black : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 3.8,
                          ),
                        ),
                        );
                      }

                  Widget title(){
                    return Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 209, 214, 231),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:Center(
                        child: TextFormField(
                          controller: _titleController ,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 74, 74, 74),
                              fontSize: 17,
                            ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Event Name",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 74, 74, 74),
                              fontSize: 17,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                          ),
                        ),
                      ),
                    ),
                    );
                  }

                  Widget description(){
                    return Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 209, 214, 231),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 17,
                          ),
                          maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Event description",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 17,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                        ),
                      ),
                    );
                  }
                                       
}