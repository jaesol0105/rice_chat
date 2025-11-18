import 'package:flutter/material.dart';
import 'package:rice_chat/chat_detail_page.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});
  @override
  State<ViewPage> createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  int imageIndex = 1;
  List<String> imageNumbers = [
    "https://picsum.photos/300/300",
    "https://picsum.photos/301/301",
    "https://picsum.photos/302/302",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔥  바탕 화면 색상 🔥
      backgroundColor: Color(0xFFFCF5F3),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 35),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // 🔥 회색 이미지 화면 🔥
          Container(
            height: 330,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                // 🔥 중앙 이미지  🔥
                image: NetworkImage(imageNumbers[imageIndex]),
                fit: BoxFit.cover,
              ),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 🔥 이미지 아이콘 왼쪽 🔥
                IconButton(
                  onPressed: () {
                    setState(() {
                      imageIndex == 0 ? imageIndex = 2 : imageIndex--;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🔥 이미지 아이콘 3개 🔥
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: imageIndex == 0
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: imageIndex == 1
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: imageIndex == 2
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
                // 🔥 이미지 아이콘 오른쪽 🔥
                IconButton(
                  onPressed: () {
                    setState(() {
                      imageIndex == 2 ? imageIndex = 0 : imageIndex++;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 이미지 왼쪽 원형 🔥
              Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200/200"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // 🔥 이름 제목 🔥
                children: [
                  Text(
                    '권태윤',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF373737),
                    ),
                  ),
                  Row(
                    children: [
                      // 🔥 이미지 왼쪽 일식 🔥
                      Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://img.icons8.com/color/200/sushi.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text('일식', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      // 🔥 이미지 오른쪽 회/초밥 🔥
                      Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrangeAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://img.icons8.com/ios/200/sushi.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text('회/초밥', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥  왼쪽 메인 제목 🔥
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "밥 같이 먹으실 여성분 찾고있어요\n:>",
                  style: TextStyle(fontSize: 20, color: Color(0xFF373737)),
                ),
              ),
              // 🔥 이미지 왼쪽 하단 숫자  🔥
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('(2/10)'),
              ),
            ],
          ),
          Spacer(),
          // 🔥 메세지 창  🔥
          InkWell(
            onTap: () {
              // 🔥 채팅 페이지로 이동 🔥
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatDetailPage()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF983E24),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "채팅으로 이동",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  // 🔥 메세지 오른쪽 이동 아이콘 🔥
                  Padding(
                    padding: const EdgeInsets.all(10),
                    // 🔥  메세지 창 화살표 아이콘 🔥
                    child: Icon(Icons.send_outlined, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
