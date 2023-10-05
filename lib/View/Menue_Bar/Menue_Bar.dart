import 'package:aichat/View/Menue_Bar/Controler.dart';
import 'package:aichat/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../GoogleAuth/Googleauth.dart';
import '../../page/ChatHistoryPage.dart';
import '../../page/ChatPage.dart';
import '../../stores/AIChatStore.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

import '../../utils/Time.dart';
import '../../utils/Utils.dart';
import '../../widgets/custom_outlined_button.dart';

class menuebar extends StatefulWidget {
  const menuebar({super.key});

  @override
  State<menuebar> createState() => _menuebarState();
}

class _menuebarState extends State<menuebar> {
  final Isloading = Get.put(MenueLoader());
  final logout = Get.put(AuthController());
  void _handleClickModel(Map chatModel) {
    final store = Provider.of<AIChatStore>(context, listen: false);
    store.fixChatList();
    Utils.jumpPage(
      context,
      ChatPage(
        chatId: const Uuid().v4(),
        autofocus: true,
        chatType: chatModel['type'],
      ),
    );
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
                      color: appTheme.blueGray400,
                      size: 17,
                    ),
                  )),
              decoration: BoxDecoration(
                  border: Border.all(color: appTheme.blueGray400, width: 2),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          title: Text(
            'Menu',
            style: theme.textTheme.titleLarge!.copyWith(
              height: 1.27,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                Isloading.isLoading.value
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : InkWell(
                        onTap: () {
                          Isloading.Startnewchat(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 420.v,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              'Start New Chat',
                              style: CustomTextStyles.titleLarge21,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 10.v),
                CustomOutlinedButton(
                  onTap: () {
                    logout.signOut(context);
                  },
                  text: "Log Out".tr,
                ),
                SizedBox(height: 10.v),
                SizedBox(height: 10.v),
                CustomOutlinedButton(
                  onTap: (() {
                    Get.to(ChatHistoryPage());
                  }),
                  text: "Chat History".tr,
                ),
                SizedBox(height: 10.v),
                if (store.homeHistoryList.length > 0)
                  _renderTitle(
                    'History',
                    rightContent: SizedBox(
                      width: 45,
                      child: GestureDetector(
                        onTap: () {
                          Utils.jumpPage(context, const ChatHistoryPage());
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'All',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                height: 18 / 16,
                                color: appTheme.blueGray400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              height: 16,
                              child: Image(
                                color: appTheme.blueGray400,
                                image: AssetImage(
                                  'images/arrow_icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (store.homeHistoryList.length > 0)
                  _renderChatListWidget(
                    store.homeHistoryList,
                  ),
                // _renderTitle('Chat Model'),
              ],
            ),
          ),
        ));
  }

  Widget _renderChatListWidget(List chatList) {
    List<Widget> list = [];
    for (var i = 0; i < chatList.length; i++) {
      list.add(
        _genChatItemWidget(chatList[i]),
      );
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          ...list,
        ],
      ),
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
                          color: appTheme.blueGray400,
                          fontSize: 16,
                          height: 24 / 16,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      chat['messages'][0]['content'],
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
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
                color: Colors.red,
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
          title: Text(
            'Confirm deletion?',
            style: TextStyle(color: appTheme.black900),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: appTheme.blueGray900),
              ),
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

  Widget _renderTitle(
    String text, {
    Widget? rightContent,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 8),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (rightContent != null) rightContent,
        ],
      ),
    );
  }

  Widget _genChatModelItemWidget(Map chatModel) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _handleClickModel(chatModel);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(229, 245, 244, 1),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatModel['name'],
                            softWrap: true,
                            style: const TextStyle(
                              color: Color.fromRGBO(1, 2, 6, 1),
                              fontSize: 16,
                              height: 24 / 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            chatModel['desc'],
                            softWrap: true,
                            style: const TextStyle(
                              color: Color.fromRGBO(144, 152, 154, 1),
                              fontSize: 16,
                              height: 22 / 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      child: const Image(
                        image: AssetImage('images/arrow_icon.png'),
                        width: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
