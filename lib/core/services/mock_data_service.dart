import '../models/models.dart';

/// Mock data service for UI development
class MockDataService {
  //MockDataService._();

  // ==================== USERS ====================
  static final List<UserModel> mockUsers = [
    UserModel(
      uid: 'user_001',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      country: 'USA',
      gender: 'Female',
      photoUrl: 'https://i.pravatar.cc/150?img=1',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_002',
      name: 'Bob Smith',
      email: 'bob@example.com',
      country: 'UK',
      gender: 'Male',
      photoUrl: 'https://i.pravatar.cc/150?img=2',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_003',
      name: 'Karim Rahman',
      email: 'karim@example.com',
      country: 'Bangladesh',
      division: 'Dhaka',
      district: 'Gazipur',
      gender: 'Male',
      photoUrl: 'https://i.pravatar.cc/150?img=3',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_004',
      name: 'Fatima Akter',
      email: 'fatima@example.com',
      country: 'Bangladesh',
      division: 'Chittagong',
      district: 'Narsingdi',
      gender: 'Female',
      photoUrl: 'https://i.pravatar.cc/150?img=4',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_005',
      name: 'Raj Patel',
      email: 'raj@example.com',
      country: 'India',
      gender: 'Male',
      photoUrl: 'https://i.pravatar.cc/150?img=5',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_006',
      name: 'Priya Sharma',
      email: 'priya@example.com',
      country: 'India',
      gender: 'Female',
      photoUrl: 'https://i.pravatar.cc/150?img=6',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_007',
      name: 'John Doe',
      email: 'john@example.com',
      country: 'Canada',
      gender: 'Male',
      photoUrl: 'https://i.pravatar.cc/150?img=7',
      isVerified: true,
    ),
    UserModel(
      uid: 'user_008',
      name: 'Emma Wilson',
      email: 'emma@example.com',
      country: 'Australia',
      gender: 'Female',
      photoUrl: 'https://i.pravatar.cc/150?img=8',
      isVerified: true,
    ),
  ];

  // ==================== CHATS ====================
  static final List<ChatModel> mockChats = [
    ChatModel(
      id: 'chat_001',
      name: 'Alice Johnson',
      photo: 'https://i.pravatar.cc/150?img=1',
      lastMessage: 'Hey there! How are you?',
      time: '10:30 AM',
      recipientUid: 'user_001',
      unreadCount: 2,
    ),
    ChatModel(
      id: 'chat_002',
      name: 'Bob Smith',
      photo: 'https://i.pravatar.cc/150?img=2',
      lastMessage: "Let's call later.",
      time: '9:15 AM',
      recipientUid: 'user_002',
      unreadCount: 0,
    ),
    ChatModel(
      id: 'chat_003',
      name: 'Karim Rahman',
      photo: 'https://i.pravatar.cc/150?img=3',
      lastMessage: 'Did you see the match?',
      time: 'Yesterday',
      recipientUid: 'user_003',
      unreadCount: 5,
    ),
    ChatModel(
      id: 'chat_004',
      name: 'Fatima Akter',
      photo: 'https://i.pravatar.cc/150?img=4',
      lastMessage: 'Thanks for helping!',
      time: 'Yesterday',
      recipientUid: 'user_004',
      unreadCount: 0,
    ),
  ];

  // ==================== ROOMS ====================
  static final List<RoomModel> mockRooms = [
    RoomModel(
      id: 'room_001',
      name: 'Flutter Devs',
      topic: 'State Management Discussion',
      participants: ['user_001', 'user_002', 'user_003'],
      createdAt: '10 mins ago',
      creatorUid: 'user_001',
      isActive: true,
    ),
    RoomModel(
      id: 'room_002',
      name: 'Tech Talk',
      topic: 'AI & Ethics',
      participants: ['user_004', 'user_005'],
      createdAt: '25 mins ago',
      creatorUid: 'user_004',
      isActive: true,
    ),
    RoomModel(
      id: 'room_003',
      name: 'Music Lovers',
      topic: 'Favorite Albums of 2025',
      participants: ['user_006', 'user_007', 'user_008'],
      createdAt: '1 hour ago',
      creatorUid: 'user_006',
      isActive: true,
    ),
    RoomModel(
      id: 'room_004',
      name: 'Book Club',
      topic: 'Sci-Fi Recommendations',
      participants: ['user_001', 'user_005', 'user_007'],
      createdAt: '2 hours ago',
      creatorUid: 'user_007',
      isActive: true,
    ),
  ];

  // ==================== MESSAGES ====================
  static final List<MessageModel> mockMessages = [
    MessageModel(
      id: 'msg_001',
      senderId: 'user_001',
      receiverId: 'current_user',
      text: 'Hey! How are you doing?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    MessageModel(
      id: 'msg_002',
      senderId: 'current_user',
      receiverId: 'user_001',
      text: "I'm good, thanks! How about you?",
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      isRead: true,
    ),
    MessageModel(
      id: 'msg_003',
      senderId: 'user_001',
      receiverId: 'current_user',
      text: 'Great! Working on a new project.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
      isRead: true,
    ),
    MessageModel(
      id: 'msg_004',
      senderId: 'current_user',
      receiverId: 'user_001',
      text: 'That sounds interesting! Tell me more.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      isRead: true,
    ),
    MessageModel(
      id: 'msg_005',
      senderId: 'user_001',
      receiverId: 'current_user',
      text: "It's a Flutter app with video chat features!",
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
      isRead: true,
    ),
  ];

  // ==================== COUNTRIES & LOCATIONS ====================
  static const List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Argentina',
    'Australia',
    'Austria',
    'Bangladesh',
    'Belgium',
    'Brazil',
    'Canada',
    'China',
    'Denmark',
    'Egypt',
    'Finland',
    'France',
    'Germany',
    'Greece',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Italy',
    'Japan',
    'Malaysia',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Norway',
    'Pakistan',
    'Portugal',
    'Qatar',
    'Russia',
    'Saudi Arabia',
    'Singapore',
    'South Africa',
    'South Korea',
    'Spain',
    'Sri Lanka',
    'Sweden',
    'Switzerland',
    'Thailand',
    'Turkey',
    'United Arab Emirates',
    'United Kingdom',
    'United States of America',
    'Vietnam',
    'Zimbabwe',
  ];

  static const List<String> bangladeshDivisions = [
    'Dhaka',
    'Chittagong',
    'Rajshahi',
    'Khulna',
    'Barisal',
    'Sylhet',
    'Rangpur',
    'Mymensingh',
  ];

  static const Map<String, List<String>> bangladeshDistricts = {
    'Dhaka': [
      'Dhaka',
      'Gazipur',
      'Narayanganj',
      'Narsingdi',
      'Tangail',
      'Manikganj',
    ],
    'Chittagong': [
      'Chittagong',
      "Cox's Bazar",
      'Comilla',
      'Brahmanbaria',
      'Chandpur',
    ],
    'Rajshahi': ['Rajshahi', 'Bogra', 'Pabna', 'Sirajganj', 'Natore'],
    'Khulna': ['Khulna', 'Jessore', 'Satkhira', 'Bagerhat', 'Kushtia'],
    'Barisal': ['Barisal', 'Patuakhali', 'Bhola', 'Pirojpur', 'Jhalokati'],
    'Sylhet': ['Sylhet', 'Moulvibazar', 'Habiganj', 'Sunamganj'],
    'Rangpur': ['Rangpur', 'Dinajpur', 'Kurigram', 'Gaibandha', 'Nilphamari'],
    'Mymensingh': ['Mymensingh', 'Jamalpur', 'Netrokona', 'Sherpur'],
  };

  // ==================== HELPER METHODS ====================
  static List<UserModel> getFilteredUsers({
    String? searchText,
    String? gender,
    String? country,
    String? division,
    String? district,
    String? excludeUid,
  }) {
    return mockUsers.where((user) {
      if (excludeUid != null && user.uid == excludeUid) return false;

      if (searchText != null && searchText.isNotEmpty) {
        if (!user.name.toLowerCase().contains(searchText.toLowerCase())) {
          return false;
        }
      }

      if (gender != null && gender != 'All' && gender.isNotEmpty) {
        if (user.gender.toLowerCase() != gender.toLowerCase()) return false;
      }

      if (country != null && country != 'All Country' && country.isNotEmpty) {
        if (user.country.toLowerCase() != country.toLowerCase()) return false;
      }

      if (division != null && division.isNotEmpty) {
        if (user.division.toLowerCase() != division.toLowerCase()) return false;
      }

      if (district != null && district.isNotEmpty) {
        if (user.district.toLowerCase() != district.toLowerCase()) return false;
      }

      return true;
    }).toList();
  }
}
