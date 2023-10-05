import 'package:aichat/page/ChatPage.dart';
import 'package:aichat/theme/theme_helper.dart';
import 'package:aichat/utils/Time.dart';
import 'package:aichat/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aichat/stores/AIChatStore.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({Key? key}) : super(key: key);

  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AIChatStore>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: appTheme.blueGray900,
                    size: 17,
                  ),
                )),
            decoration: BoxDecoration(
                border: Border.all(color: appTheme.blueGray900, width: 2),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        title: Text(
          'History',
          style: theme.textTheme.titleLarge!.copyWith(
            height: 1.27,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _renderChatListWidget(
                store.sortChatList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderChatListWidget(List chatList) {
    // List<Widget> list = [];
    // for (var i = 0; i < chatList.length; i++) {
    //   list.add(
    //     _genChatItemWidget(chatList[i]),
    //   );
    // }
    // return SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ...list,
    //       const SizedBox(height: 20),
    //     ],
    //   ),
    // );

    return ListView.builder(
      reverse: false,
      itemCount: chatList.length,
      itemBuilder: (BuildContext context, int index) {
        return _genChatItemWidget(chatList[index]);
      },
    );
  }

  Widget _genChatItemWidget(Map chat) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        final store = Provider.of<AIChatStore>(context, listen: false);
        store.fixChatList();
        Utils.jumpPage(
          context,
          ChatPage(
            chatId: chat['id'],
            autofocus: false,
            chatType: chat['ai']['type'],
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (chat['updatedTime'] != null)
                      Text(
                        TimeUtils().formatTime(
                          chat['updatedTime'],
                          format: 'dd/MM/yyyy HH:mm',
                        ),
                        softWrap: true,
                        style: TextStyle(
                          color: appTheme.blueGray900,
                          fontSize: 16,
                          height: 24 / 16,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      chat['messages'][0]['content'],
                      softWrap: true,
                      style: TextStyle(
                        color: appTheme.whiteA700,
                        fontSize: 20,
                        height: 24 / 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 22,
                ),
                color: Color.fromARGB(255, 220, 24, 24),
                onPressed: () {
                  _showDeleteConfirmationDialog(context, chat['id']);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 2,
            color: Color.fromRGBO(166, 166, 166, 1.0),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    String chatId,
  ) async {
    final store = Provider.of<AIChatStore>(context, listen: false);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                await store.deleteChatById(chatId);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
