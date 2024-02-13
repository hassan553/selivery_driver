import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/chatcontroller.dart';

import '../../../core/helper/notifictions_helper.dart';
import '../../../core/services/cache_storage_services.dart';
import '../../../models/chatmodel.dart';

class ChatScreen extends StatelessWidget {
  final String clientid;
  final String devicetoken;
  const ChatScreen({super.key, required this.clientid, required this.devicetoken});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController())
      ..getMessages(CacheStorageServices().id);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "دردشة مع العميل",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
                stream: controller.messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) {
                        return messages[index].senderId ==
                                CacheStorageServices().id
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 8),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        color: Colors.pinkAccent),
                                    child: Text(
                                      messages[index].message,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.greenAccent),
                                    child: Text(
                                      messages[index].message,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                      },
                      itemCount: messages.length,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                textInputAction: TextInputAction.done,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "enter text";
                  }
                  return null;
                },
                controller: controller.chatController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                onTapOutside: (e) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "اكتب الرسالة",
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              )),
              IconButton(
                  onPressed: () {
                    controller.sendMessage(MessageModel(
                        receiverId: clientid, //client
                        senderId: CacheStorageServices().id, //driver
                        dateTime: DateTime.now().toString(),
                        message: controller.chatController!.text));
                    FirebaseMessagingService.
                    sendNotification(title: "رسالة جديدة",
                        body: controller.chatController!.text,
                        userToken: devicetoken);
                    controller.chatController!.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                    size: 30,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
