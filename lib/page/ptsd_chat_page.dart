import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobstress_app/data/chat_data.dart';
import 'package:jobstress_app/data/chat_response.dart';
import 'package:jobstress_app/data/chat_select.dart';
import 'package:jobstress_app/data/gridview.dart';
import 'package:jobstress_app/data/userVO.dart';
import 'package:jobstress_app/utils/chat_message_item_ptsd.dart';
import 'package:jobstress_app/utils/color.dart';
import 'package:jobstress_app/utils/common.dart';
import 'package:jobstress_app/utils/dio_client.dart';
import 'package:jobstress_app/utils/etc.dart';

/// 챗봇 화면
class  PTSDChatPage extends StatefulWidget {

  final UserVO userVO;
  PTSDChatPage(this.userVO);

  @override
  _PTSDChatPageState createState() => _PTSDChatPageState();
}

class _PTSDChatPageState extends State<PTSDChatPage> with TickerProviderStateMixin {

  final TextEditingController _textEditingController = TextEditingController();

  ChatSelect select = ChatSelect();
  FocusNode _focusNodeInputType = FocusNode(); // 입력란 활성
  PTSDChatResponse _chatResponse = PTSDChatResponse();

  List<GridViewSelection> gridGroup = []; // 응답 선택문항 Group
  final List<ChatMessageItemPTSD> _messageItemList = [];

  String globalQuestionNo; // input questionNO
  String userIdx;          // DB index

  var currentProgress = 0;        // 진행 갯수
  var currentProgressValue = 0.0; // 진행 게이지

  final int lastNumber = 39;      // 39개 문항
  double rateIncrease  = 0.0256;  // 증가율 39/100

  bool isShowComposer = false;    // 입력란 비/활성화
  bool _isComposing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userIdx = '-1'; // 초기 무조건 -1로 시작

    ChatSelect select = ChatSelect(questionNo: int.parse('0'), answerNo:'', answerMessage: '');
    _loadQuestion(select);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Common.doAppBar('직무스트레스 상담'),

        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Column(
                children: [

                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (context, index) => _messageItemList[index],
                      itemCount: _messageItemList.length,
                    ),
                  ),

                  SizedBox(height: 1.0),

                  Visibility(
                    visible: isShowComposer,
                    child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).cardColor),
                      child: _buildTextComposer(),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(2.0))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          SizedBox(width:90,
                              child: Text('진행률 $currentProgress/$lastNumber', textScaleFactor: 0.9, style: TextStyle(fontWeight: FontWeight.bold))),
                          Container(margin: EdgeInsets.symmetric(vertical: 5),
                            height: 12,
                            width: MediaQuery.of(context).size.width - 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(value: currentProgressValue, backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(mainColor)),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }


  void _loadQuestion(ChatSelect select) async {
    _chatResponse = await client.dioPTSDChat(toMap(select.questionNo.toString(), select.answerNo, select.answerMessage));

    //print('----> [PTSD] questionMessage : '+ _chatResponse.questionMessage+' / userIdx : '+userIdx);
    userIdx = _chatResponse.userIdx;

    Future.delayed(const Duration(milliseconds: 700), () {

      if (_chatResponse.answerType == 'none' ) //answerType 이 none 일때
      {
        isShowComposer = false;
        _loadQuestionNone(_chatResponse);
      }
      else if (_chatResponse.answerType == 'select')
      {
        isShowComposer = false;
        _loadQuestionSelect(_chatResponse);
      }
      else if(_chatResponse.answerType == 'input')
      {
        isShowComposer = true;
        _loadQuestionInput(_chatResponse);
      }

    });
  }

  void _loadQuestionSelect(PTSDChatResponse chatResponse) {
    print('----> [PTSD] loadQuestionSelect execution');
    List<bool>isSelectColor = [];

    for(int i = 0; i<chatResponse.chatAnswersData.length ; i++){
      isSelectColor.add(false) ;
    }

    ChatDataPTSD questionChatData = ChatDataPTSD();

    questionChatData.questionNo      = chatResponse.questionNo;
    questionChatData.message         = chatResponse.questionMessage;
    questionChatData.answerType      = chatResponse.answerType;
    questionChatData.chatAnswersData = chatResponse.chatAnswersData;
    questionChatData.messageType = 'RECEIVE';

    ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData, isSelectColor:isSelectColor,runOnce:true,
        animationController:AnimationController(duration: Duration(milliseconds:1000), vsync: this), callback:(select)=>getAnswer(select));

    setState(() {
      _messageItemList.insert(0, messageItem);
    });
    messageItem.animationController.forward();
  }


  void _loadQuestionNone(PTSDChatResponse _chatResponse) {
    print('----> [PTSD] loadQuestionNone execution');

    String msg = _chatResponse.questionMessage;

    if(msg == 'GREEN' || msg == 'YELLOW' || msg == 'RED')
    {
      ChatDataPTSD questionChatData = ChatDataPTSD();

      questionChatData.questionNo      = _chatResponse.questionNo;
      questionChatData.message         = _chatResponse.questionMessage;
      questionChatData.answerType      = _chatResponse.answerType;
      questionChatData.chatAnswersData = _chatResponse.chatAnswersData;
      questionChatData.messageType     = 'RECEIVE';

      ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData,
          animationController: AnimationController(duration: Duration(milliseconds:1000), vsync: this));

      setState(() {
        _messageItemList.insert(0, messageItem);
      });

      messageItem.animationController.forward();
    }
    else {
        ChatDataPTSD questionChatData = ChatDataPTSD();

        questionChatData.questionNo      = _chatResponse.questionNo;
        questionChatData.message         = _chatResponse.questionMessage;
        questionChatData.answerType      = _chatResponse.answerType;
        questionChatData.chatAnswersData = _chatResponse.chatAnswersData;
        questionChatData.messageType = 'RECEIVE';

        ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData,
            animationController:AnimationController(duration: Duration(milliseconds:1000), vsync: this));

        setState(() {
          _messageItemList.insert(0, messageItem);
        });

        messageItem.animationController.forward();

        ChatSelect select = ChatSelect();
        select.questionNo = int.parse(questionChatData.questionNo);
        select.answerNo ='';
        select.answerMessage ='';

        currentProgress++;
        currentProgressValue+=rateIncrease;

        _loadQuestion(select);
      }
  }

  void _loadQuestionInput(PTSDChatResponse chatResponse) {
    print('----> [PTSD] loadQuestionInput execution');

    ChatDataPTSD questionChatData = ChatDataPTSD();
    globalQuestionNo  = chatResponse.questionNo; // input 질문 번호 전역변수로

    questionChatData.questionNo      = chatResponse.questionNo;
    questionChatData.message         = chatResponse.questionMessage;
    questionChatData.answerType      = chatResponse.answerType;
    questionChatData.chatAnswersData = chatResponse.chatAnswersData;
    questionChatData.messageType = 'RECEIVE';

    ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData,
        animationController:AnimationController(duration: Duration(milliseconds:1000), vsync: this));

    setState(() {
      _messageItemList.insert(0, messageItem);
    });

    messageItem.animationController.forward();
    _focusNodeInputType.requestFocus();

  }

  void getAnswer(ChatSelect select){

    print('----> [PTSD Answer] questionNo : '+select.questionNo.toString()+' / answerNo : '+select.answerNo.toString()+' / answerMessage : '+select.answerMessage.toString());

    final questionChatData = ChatDataPTSD();
    questionChatData.messageType   = 'SEND'; // ex) 예 아니오
    questionChatData.message       = select.answerMessage;

    ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData,
        animationController:AnimationController(duration: Duration(milliseconds:1000), vsync: this));

    setState(() {
      _messageItemList.insert(0, messageItem);
    });

    messageItem.animationController.forward();
    _loadQuestion(select);

    if(currentProgress == lastNumber) // 검사 종료
    {
      currentProgress++;
      currentProgressValue = 1;
    }
    else{
      currentProgress++;
      currentProgressValue+=rateIncrease;
    }
  }

  Map<String, dynamic> toMap(String questionNo, String answerNo, String answerMessage){
    Map<String,dynamic> toMap ={
      'userIdx'       : userIdx,
      'questionNo'    : questionNo,
      'answerNo'      : answerNo,
      "answerMessage" : answerMessage,
      "age"           : widget.userVO.age,
      "job"           : widget.userVO.job,
      "sex"           : widget.userVO.gender,
      "email"         : widget.userVO.email,

    };
    return toMap;
  }

  // 채팅 입력 & 보내기버튼
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Row(
        children: [
          Flexible(
            flex: 9,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MediaQuery(
                        data: Etc.getScaleFontSize(context, fontSize:1.0),
                        child: TextField(
                          focusNode: _focusNodeInputType,
                          controller: _textEditingController,
                          keyboardType: TextInputType.number,
                          onChanged: (String text) {
                            setState(() {
                              _isComposing = text.length > 0;
                            });
                          },
                          onSubmitted: _handleSubmitted,
                          decoration: InputDecoration.collapsed(hintText: '메시지를 입력하세요.',hintStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: CupertinoButton(
                        minSize: 0.0,
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        color: Color(0xFF898989),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Text('전송', textScaleFactor:1.0, style: TextStyle(color: Colors.white),),
                        onPressed: () => _handleSubmittedExtend('SEND', _textEditingController.text),
                        // onPressed: _isComposing ? () => _handleSubmittedExtend('SEND', _textEditingController.text) : null,
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _handleSubmittedExtend('SEND', text);
  }

  // Send Message
  void _handleSubmittedExtend(String messageType, String text) {
    FocusScope.of(context).unfocus(); // 키보드 내리기

    _textEditingController.clear();

    if(text == '') return;

    setState(() {
      _isComposing = false;
    });

    final questionChatData = ChatDataPTSD();
    questionChatData.messageType = 'SEND'; //ex) 예 아니오
    questionChatData.message     = text;

    ChatMessageItemPTSD message = ChatMessageItemPTSD(
        chatData: questionChatData, animationController: AnimationController(duration: Duration(milliseconds: 1000), vsync: this),);

    setState(() {
      _messageItemList.insert(0, message); // 자신이 보낸 message insert 후 화면에 뿌리기
    });

    ChatSelect select = ChatSelect();
    select.questionNo = int.parse(globalQuestionNo);
    select.answerNo = '';
    select.answerMessage = text;

    _loadQuestion(select);

    currentProgress++;
    currentProgressValue+=rateIncrease;

    message.animationController.forward();// 한칸식 위로 이동(chatItem)
  }


}
