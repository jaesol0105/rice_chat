import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime? time; // ✅ 문자열 대신 DateTime?
  final String? imageUrl;
  final bool isMine;
  final bool showProfile;

  const ChatCard({
    super.key,
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isMine,
    required this.showProfile,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = time;

    Widget timeRight() {
      if (dateTime == null) return const SizedBox();
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateFormat("yyyy/MM/dd", "ko_KR").format(dateTime),
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          Text(
            DateFormat("a hh:mm", "ko_KR").format(dateTime),
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
        ],
      );
    }

    Widget timeLeft() {
      if (dateTime == null) return const SizedBox();
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("yyyy/MM/dd", "ko_KR").format(dateTime),
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          Text(
            DateFormat("a hh:mm", "ko_KR").format(dateTime),
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
        ],
      );
    }

    if (isMine) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          timeRight(),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
              color: const Color(0xff4CAF50),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              message,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: !showProfile
                ? const SizedBox(width: 50)
                : Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[400],
                    child: (imageUrl == null || imageUrl!.isEmpty)
                        ? const Icon(Icons.person, size: 30)
                        : Image.network(imageUrl!, fit: BoxFit.cover),
                  ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showProfile) ...[
                Text(
                  senderName,
                  style: const TextStyle(color: Color(0xff343434), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      message,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: const TextStyle(color: Color(0xFF343434)),
                    ),
                  ),
                  const SizedBox(width: 4),
                  timeLeft(),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}
