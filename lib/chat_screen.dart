import 'package:flutter/material.dart';

class ChatUser {
  final String name;
  final String message;
  final String time;
  final NetworkImage image;
  final bool unread;

  ChatUser({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    this.unread = false,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "";

 List<ChatUser> chatUsers = [
  ChatUser(name: "Amit Sharma", message: "Is this property still av...", time: "4 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=1"), unread: true),
  ChatUser(name: "Priya Mehta", message: "Can we schedule a visit...", time: "4 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=2")),
  ChatUser(name: "Rahul Verma", message: "What is the final price?", time: "10 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=3"), unread: true),
  ChatUser(name: "Neha Kapoor", message: "Is financing available for...", time: "15 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=4")),

  // Additional 20 entries
  ChatUser(name: "Karan Malhotra", message: "I'm interested in the 3BHK...", time: "20 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=5")),
  ChatUser(name: "Simran Kaur", message: "Can you share the brochure?", time: "22 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=6"), unread: true),
  ChatUser(name: "Vikram Joshi", message: "Is there a parking space?", time: "25 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=7")),
  ChatUser(name: "Anjali Rao", message: "What's the neighborhood like?", time: "30 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=8")),
  ChatUser(name: "Rohit Desai", message: "Can I visit this weekend?", time: "35 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=9"), unread: true),
  ChatUser(name: "Meena Iyer", message: "Is it pet-friendly?", time: "40 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=10")),
  ChatUser(name: "Arjun Singh", message: "Any schools nearby?", time: "45 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=11")),
  ChatUser(name: "Sneha Nair", message: "Can I get a virtual tour?", time: "50 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=12"), unread: true),
  ChatUser(name: "Dev Patel", message: "Is the price negotiable?", time: "55 minutes ago", image: NetworkImage("https://picsum.photos/100/100?random=13")),
  ChatUser(name: "Tanya Bhatia", message: "How old is the property?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=14")),
  ChatUser(name: "Manish Agarwal", message: "Can I pay in installments?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=15")),
  ChatUser(name: "Ritika Jain", message: "Is it fully furnished?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=16"), unread: true),
  ChatUser(name: "Siddharth Roy", message: "What's the carpet area?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=17")),
  ChatUser(name: "Pooja Sinha", message: "Can I speak to the owner?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=18")),
  ChatUser(name: "Nikhil Bansal", message: "Is it RERA approved?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=19")),
  ChatUser(name: "Isha Malviya", message: "Any upcoming open houses?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=20")),
  ChatUser(name: "Rajeev Menon", message: "Can I get a discount?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=21"), unread: true),
  ChatUser(name: "Shruti Deshmukh", message: "Is it close to public transport?", time: "1 hour ago", image: NetworkImage("https://picsum.photos/100/100?random=22")),

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search for City...",
                filled: true,
                fillColor: Colors.amber[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

        
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber[200],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Unread"),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                chatListView(chatUsers), 
                chatListView(chatUsers.where((u) => u.unread).toList()), // Unread
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatListView(List<ChatUser> chatUsers) {
    final filteredUsers = chatUsers
        .where((u) => u.name.toLowerCase().contains(searchQuery) ||
            u.message.toLowerCase().contains(searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(user.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.amber,
          ),
          title:
              Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(user.message,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Text(user.time,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatDetailScreen(user: user)),
            );
          },
        );
      },
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;
  const ChatDetailScreen({super.key, required this.user});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = []; // holds static chat

  final List<String> replyQueue = [
    "Hello! How can I help you today?",
    "I understand you're interested in our property. What specific information would you like to know?",
    "Great! I'd be happy to schedule a visit for you. When would be convenient?",
    "Perfect! I'll send you the detailed brochure and pricing information shortly.",
    "Thank you for your interest! I'll connect you with our property specialist who can assist you further."
  ];

  int currentReplyIndex = 0;

  void sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "isMe": true});
    });
    sendReplies();
  }

  void sendReplies() {
    if (currentReplyIndex < replyQueue.length) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            messages.add({
              "text": replyQueue[currentReplyIndex],
              "isMe": false,
            });
            currentReplyIndex++;
          });
        }
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.user.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.amber,
            ),
            const SizedBox(width: 10),
            Text(widget.user.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg["isMe"]
                          ? Colors.amber[200]
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(msg["text"]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      cursorRadius: const Radius.circular(10),
                      controller: _controller,
                      decoration:
                          const InputDecoration(hintText: "Type a message..."),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.amber),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
