import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget{
  
  const ViewData({super.key,required this. document,required this.id});
  final Map<String,dynamic> document;
  final String id;

  @override
  _ViewDatastate createState()=>  _ViewDatastate();
}
class _ViewDatastate extends State<ViewData> {
  //TextEditingController _titleController;
  //TextEditingController _descriptionController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String type ;
  late String category;
  bool edit = false;

  //@override
  //void initState(){
    //super.initState();
    //String title = Widget.document["title"] == null
    //?"hey there"
    //:widget.document["title"];
     //_titleController= TextEditingController(text: title);
     //descriptionController = TextEditingController(text: widget.document["description"]);
     // type  = widget.document["task"];
      //category  = widget.document["Category"];
  //}

  @override
    void initState() {
      super.initState();
      String title = widget.document["title"] ?? "hey there";
      _titleController = TextEditingController(text: title);
      _descriptionController = TextEditingController(text: widget.document["description"]);
      type = widget.document["task"];
      category = widget.document["Category"];
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
    backgroundColor: const Color(0xff1d1e26),
    body:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                   Color.fromARGB(255, 145, 215, 211),
                   Color.fromARGB(255, 235, 160, 218),
                  ]),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 28,
                      ),),
                    

                    Row(
                      children:[
                    IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                        .collection("EventBase")
                        .doc(widget.id)
                        .delete()
                        .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(
                      Icons.delete,
                      color:Colors.white,
                      size: 28,
                      ),),

                      IconButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                      icon: Icon(
                      Icons.edit,
                      color: edit?Colors.white:Colors.white,
                      size: 28,
                      ),),

                    ],
                  ),
                ],
              ),


                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        edit?"Editing":"View",
                        style: const TextStyle(
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
                        "Your event",
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
                          taskSelect("Important",0xff2664fa),
                            const SizedBox(
                              width: 20,
                            ),
                          taskSelect("Planned",0xff2bc8d9),
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
                                      edit? button() : Container(),
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
                      FirebaseFirestore.instance.collection("EventBase").doc(widget.id).update({
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
                          "Update event",
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
                          onTap: edit
                          ?(){
                            setState(() {
                              type = label;
                            });
                          }
                          :null,
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
                          onTap: edit
                          ? (){
                            setState(() {
                              category = label;
                            });
                          }:null,
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
                          enabled: edit,
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
                        enabled: edit,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 17,
                          ),
                          maxLines: null,
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
                    );
                  }

                  Widget chipData(String label,int color){
                    return Chip(
                      backgroundColor: Color(color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                      ),
                      ),
                      label:Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 3.8,
                        ),
                    );
                  }            
                  
}