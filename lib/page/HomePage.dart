import 'package:aichat/components/QuestionInput.dart';
import 'package:aichat/core/utils/image_constant.dart';
import 'package:aichat/core/utils/size_utils.dart';
import 'package:aichat/page/ChatHistoryPage.dart';
import 'package:aichat/page/ChatPage.dart';
import 'package:get/get.dart';
import 'package:aichat/theme/theme_helper.dart';
import 'package:aichat/utils/Chatgpt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aichat/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:aichat/stores/AIChatStore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../View/Menue_Bar/Menue_Bar.dart';
import '../View/new_chat_form_screen/new_chat_form_screen.dart';
import '../widgets/app_bar/appbar_image.dart';
import '../widgets/app_bar/appbar_image_1.dart';
import '../widgets/app_bar/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController questionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _renderBottomInputWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        handleClickInput();
      },
      child: const QuestionInput(
        chat: {},
        autofocus: false,
        enabled: false,
      ),
    );
  }

  @override
  void initState() {
    loadUserProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  void handleClickInput() async {
    final store = Provider.of<AIChatStore>(context, listen: false);
    store.fixChatList();
    Utils.jumpPage(
      context,
      ChatPage(
        chatType: 'chat',
        autofocus: true,
        chatId: const Uuid().v4(),
      ),
    );
  }

  Future loadUserProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('UserData').get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AIChatStore>(context, listen: true);

    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 59.h,
        leading: AppbarImage(
          svgPath: ImageConstant.imgGlobe,
          margin: EdgeInsets.only(
            left: 20.h,
            top: 9.v,
            bottom: 9.v,
          ),
        ),
        actions: [
          AppbarImage1(
            onTap: () {
              Get.to(menuebar());
            },
            svgPath: ImageConstant.imgMenu,
            margin: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 15.v,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  height: 16,
                                  child: Image(
                                    color: appTheme.blueGray400,
                                    image: AssetImage('images/arrow_icon.png'),
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
                    // _renderChatModelListWidget(),
                    SizedBox(
                      height: 400.h,
                    ),
                    Text(
                      "Lets get this conversation between $UserName and $AIName started!",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge!.copyWith(
                        height: 1.27,
                      ),
                    )
                  ],
                ),
              ),
            ),
            _renderBottomInputWidget(),
          ],
        ),
      ),
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

  Widget _renderChatModelListWidget() {
    List<Widget> list = [];
    for (var i = 0; i < ChatGPT.chatModelList.length; i++) {
      list.add(
        _genChatModelItemWidget(ChatGPT.chatModelList[i]),
      );
    }
    list.add(
      const SizedBox(height: 10),
    );
    return Column(
      children: list,
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
                      // Text(
                      //   TimeUtils().formatTime(
                      //     chat['updatedTime'],
                      //     format: 'dd/MM/yyyy HH:mm',
                      //   ),
                      //   softWrap: true,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 16,
                      //     height: 24 / 16,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                    Text(
                      chat['messages'][0]['content'],
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
