import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
    List <Message> messagesList=[];

  void sendMessage({required String message, required var email}) {
    messages
        .add({'message': message, 'createdAt': DateTime.now(), 'id': email});
  }

  void getMessages(){
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messagesList.clear();
    for (var doc in event.docs) {
      messagesList.add(Message.fromJson(doc));
    }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
