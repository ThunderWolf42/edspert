import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edspert/src/data/data_source/discussion_data_source.dart';
import 'package:edspert/src/data/models/discussion_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {

  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Diskusi",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList()
          ),
          _buildMessageInput()          
        ],
      ) ,
    );
  }
  Widget _buildMessageInput (){
  return Row(
    children: [
      Expanded(
        child: Container(
          
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 202, 202),
            borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            controller: _messageController,
            obscureText: false,
            
          ),
        )
        ),


       // send button 
       IconButton(
        onPressed: () async{
          await DiscussionDataSource().createDiscussion(
            DiscussionModel(
              email: "darrel@gmail.com", 
              name: "Samsul", 
              pictureUrl: null, 
              timestamp: Timestamp.now(), 
              message: _messageController.text
              )
          );

        }, 
        icon: const Icon(Icons.send_sharp)
        
        )
    ],
  );
}


   Widget _buildMessageList (){
    return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: DiscussionDataSource().streamDiscussion(),
          builder: (context, snapshot) {
            List<DiscussionModel> discussions = (snapshot.data?.docs ?? [])
                .map((e) => DiscussionModel.fromMap(e.data()))
                .toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: discussions[index].email ==
                            FirebaseAuth.instance.currentUser?.email
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue
                      ),
                      child: Text(discussions[index].message,style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),)),
                  ),
                );
              },
            );
          },
        );
 }
}

// get messages




// build message list 



// build message item


// build message input

