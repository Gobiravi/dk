import 'dart:convert';

import 'package:dikla_spirit/custom/api.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/screens/horoscope/model/horoscope_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class HoroscopeChatUI extends ConsumerWidget {
//   const HoroscopeChatUI({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         // leadingWidth: ScreenUtil().screenWidth / 2.4,
//         actions: [],
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {},
//           icon: IconButton(
//               onPressed: () {
//                 if (context.canPop()) {
//                   context.pop();
//                 } else {
//                   context.goNamed("dashboard");
//                 }
//               },
//               icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
//         ),
//         title: SizedBox(
//           // width: ScreenUtil().screenWidth / 4.5,
//           child: Text(
//             "Welcome to Dikla Spirit",
//             style: AppTheme.lightTheme.textTheme.titleMedium
//                 ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//         ),
//       ),
//       body: SizedBox(
//         height: ScreenUtil().screenHeight,
//         width: ScreenUtil().screenWidth,
//         child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return SizedBox();
//               },
//             )),
//       ),
//     );
//   }
// }

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  void sendMessage(String text) {
    state = [ChatMessage(text: text, isSentByUser: true), ...state];
  }

  void receiveMessage(String text) {
    state = [ChatMessage(text: text, isSentByUser: false), ...state];
  }
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});

class HoroscopeChatUI extends HookConsumerWidget {
  const HoroscopeChatUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);
    final typing = ref.watch(typingProvider);
    final controller = useScrollController();
    final inputController = useTextEditingController();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leadingWidth: ScreenUtil().screenWidth / 2.4,
          actions: [],
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed("dashboard");
                  }
                },
                icon: SvgPicture.asset("${Constants.imagePathAppBar}back.svg")),
          ),
          title: SizedBox(
            // width: ScreenUtil().screenWidth / 4.5,
            child: Text(
              "Welcome to Dikla Spirit",
              style: AppTheme.lightTheme.textTheme.titleMedium
                  ?.copyWith(fontSize: 17.sp, color: AppTheme.textColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  reverse: true,
                  itemCount:
                      messages.length + 1 + (typing ? 1 : 0), // +1 for header
                  itemBuilder: (context, index) {
                    final total = messages.length + (typing ? 1 : 0);

                    // Header
                    if (index == total) {
                      return SizedBox(
                        height: ScreenUtil().screenHeight * 0.73,
                        child: _buildHeader(),
                      );
                    }

                    if (typing && index == 0) {
                      return const TypingBubble();
                    }
                    final messageIndex = typing ? index - 1 : index;
                    // Message item
                    final message = messages[messageIndex];
                    return Align(
                      alignment: message.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 18.h),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: message.isSentByUser
                              ? AppTheme.strokeColor
                              : AppTheme.appBarAndBottomBarColor,
                          borderRadius: message.isSentByUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(8.sp),
                                  bottomRight: Radius.circular(8.sp),
                                  bottomLeft: Radius.circular(8.sp))
                              : BorderRadius.only(
                                  topRight: Radius.circular(8.sp),
                                  bottomRight: Radius.circular(8.sp),
                                  bottomLeft: Radius.circular(8.sp)),
                          border: Border.all(color: AppTheme.strokeColor),
                        ),
                        child: message.isSentByUser
                            ? Text(
                                message.text,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                              )
                            : buildFormattedText(message.text),
                      ),
                    );
                  },
                ),
              ),

              // Input area
              SizedBox(
                height: 80.h,
                child: _buildInputField(ref, inputController),
              ),
            ],
          ),
        ));
  }

  RichText buildFormattedText(String rawText) {
    final List<TextSpan> spans = [];

    // Split the input into lines
    final lines = rawText.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty) continue;

      // Replace leading * with bullet
      if (line.trimLeft().startsWith('*')) {
        line = line.replaceFirst(RegExp(r'^\s*\*'), '•');
      }

      int currentIndex = 0;

      // Regex patterns for markdown-like formatting
      final pattern = RegExp(
        r'(\*\*(.*?)\*\*|__(.*?)__|_(.*?)_)',
        dotAll: true,
      );

      final List<InlineSpan> lineSpans = [];

      for (final match in pattern.allMatches(line)) {
        // Add plain text before match
        if (match.start > currentIndex) {
          lineSpans
              .add(TextSpan(text: line.substring(currentIndex, match.start)));
        }

        String? boldText = match.group(2);
        String? underlineText = match.group(3);
        String? italicText = match.group(4);

        if (boldText != null) {
          lineSpans.add(TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
        } else if (underlineText != null) {
          lineSpans.add(TextSpan(
            text: underlineText,
            style: const TextStyle(decoration: TextDecoration.underline),
          ));
        } else if (italicText != null) {
          lineSpans.add(TextSpan(
            text: italicText,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ));
        }

        currentIndex = match.end;
      }

      // Add remaining plain text
      if (currentIndex < line.length) {
        lineSpans.add(TextSpan(text: line.substring(currentIndex)));
      }

      // Add the fully processed line + paragraph spacing
      spans.add(TextSpan(children: lineSpans));
      spans.add(const TextSpan(text: '\n\n'));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          height: 1.5,
        ),
        children: spans,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Please be assured that this chat is private, and your i8nformation will remain confidential. We do not share any details with third parties and are committed to protecting your privacy throughout our conversation.',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 21,
          ),
          Container(
            height: 88.h,
            width: 88.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.appBarAndBottomBarColor,
                border: Border.all(color: AppTheme.strokeColor)),
            child: Center(
              child: Image.asset(
                "${Constants.imagePath}logo.png",
                height: 75.h,
                width: 61.w,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Dikla Spirit',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700, color: AppTheme.subTextColor),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            '@diklaspirit',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodySmall
                ?.copyWith(color: AppTheme.teritiaryTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(WidgetRef ref, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppTheme.cursorColor,
              cursorWidth: 1.0,
              cursorHeight: 18.h,
              controller: controller,
              style: AppTheme.lightTheme.textTheme.labelSmall
                  ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  label: Text(
                    'Ask me anything...',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: SvgPicture.asset(
                      "${Constants.imagePathHoroscope}gallery.svg",
                      height: 24.h,
                      width: 24.h,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.strokeColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8.sp)),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8.sp)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.strokeColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8.sp)),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.strokeColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8.sp)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.errorBorder, width: 1.0)),
                  errorStyle: AppTheme.lightTheme.textTheme.bodyLarge
                      ?.copyWith(color: AppTheme.errorBorder, fontSize: 11.sp),
                  fillColor: AppTheme.appBarAndBottomBarColor),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          InkWell(
            onTap: () => _handleSendMessage(ref, controller),
            child: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Container(
                height: 51.h,
                width: 51.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.primaryColor),
                child: Center(
                  child: SvgPicture.asset(
                    "${Constants.imagePathHoroscope}send.svg",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendMessage(
      WidgetRef ref, TextEditingController controller) async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    ref.read(typingProvider.notifier).state = true;
    ref.read(chatProvider.notifier).sendMessage(text);
    controller.clear();
    try {
      final response = await ref.read(sendChatApi(text).future);
      ref.read(chatProvider.notifier).receiveMessage(response.aIResponse ?? "");
      ref.read(typingProvider.notifier).state = false;
    } catch (e) {
      debugPrint("API Error: $e");
    }
  }
}

// ================= Shipping Cart Api Provider ======================
final sendChatApi =
    FutureProvider.family<ChatModel, String>((ref, param) async {
  debugPrint("sendChatApi triggered with: $param");
  var encodedParam = json.encode({"question": param});

  final data = await ApiUtils.makeRequest(
    Constants.baseUrl + Constants.horoscopeApiUrl,
    method: "POST",
    jsonParams: encodedParam,
    useAuth: true,
    isRaw: true,
  );
  return ChatModel.fromJson(data);
});

final typingProvider = StateProvider<bool>((ref) {
  return false;
});

class ChatModel {
  bool? status;
  String? question;
  String? aIResponse;

  ChatModel({this.status, this.question, this.aIResponse});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    question = json['question'];
    aIResponse = json['AI response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['question'] = question;
    data['AI response'] = aIResponse;
    return data;
  }
}

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> dotOne, dotTwo, dotThree;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    dotOne = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
    );
    dotTwo = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.6)),
    );
    dotThree = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget dot(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(radius: 3, backgroundColor: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppTheme.appBarAndBottomBarColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.strokeColor),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          dot(dotOne),
          dot(dotTwo),
          dot(dotThree),
        ]),
      ),
    );
  }
}
