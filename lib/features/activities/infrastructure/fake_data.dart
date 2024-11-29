import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';

List<ActivityResponseData> activityResponseDataList = [
  ActivityResponseData(
    activityTitle: "Sunday Marathon",
    location: "Central Park, New York",
    activityDateAndTime: "2024-11-23 06:30:00",
    description: morningJoggingDescription,
    activityType: 1,
    image:
        "https://cavaliersouthbeach.com/wp-content/uploads/2024/01/Marathon-2024-1080x675.jpeg",
    userType: "1",
    userImage: "https://www.themezaa.com/html/pofo/images/blog-img103.jpg",
    userId: 2,
    status: "Upcoming",
    id: 1,
  ),
  ActivityResponseData(
    activityTitle: "Evening Yoga Session",
    location: "Sunset Beach, California",
    activityDateAndTime: "2024-11-25 18:00:00",
    description: eveningYogaDescription,
    activityType: 2,
    image:
        "https://img.freepik.com/premium-photo/group-people-practicing-yoga-forest-clearing_1126694-83500.jpg?w=360",
    userType: "2",
    userImage: "https://www.themezaa.com/html/pofo/images/blog-img101.jpg",
    userId: 5,
    status: "Upcoming",
    id: 2,
  ),
  ActivityResponseData(
    activityTitle: "Cycling Marathon",
    location: "Golden Gate Park, San Francisco",
    activityDateAndTime: "2024-11-30 07:00:00",
    description: cyclingMarathonDescription,
    activityType: 3,
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY9IXaG5tkOeqXBWWcxmfep3OTzrTgaYd6HQ&s",
    userType: "3",
    userImage: "https://www.themezaa.com/html/pofo/images/image-7.jpg",
    userId: 8,
    status: "Upcoming",
    id: 3,
  ),
  ActivityResponseData(
    activityTitle: "Community Cleanup Drive",
    location: "Downtown Plaza, Chicago",
    activityDateAndTime: "2024-12-02 09:00:00",
    description: cleanupDriveDescription,
    activityType: 4,
    image:
        "https://media.licdn.com/dms/image/D5612AQEj91VNAVhtaQ/article-cover_image-shrink_720_1280/0/1694444142993?e=2147483647&v=beta&t=QkTAcfIXl511U02PXfsB6_RsX3e0gmMIDxToA4AuLvU",
    userType: "4",
    userImage:
        "https://monirakandha.com/personal/wp-content/uploads/2020/04/www.themezaa.com189image-2.jpg",
    userId: 10,
    status: "Upcoming",
    id: 4,
  ),
  ActivityResponseData(
    activityTitle: "Tech Talk: Future of AI",
    location: "Tech Innovation Hub, Seattle",
    activityDateAndTime: "2024-12-05 14:00:00",
    description: techTalkDescription,
    activityType: 5,
    image:
        "https://events.eletsonline.com/tech-talk/assets/images/ai-about.webp",
    userType: "5",
    userImage: "https://www.themezaa.com/html/pofo/images/blog-img103.jpg",
    userId: 12,
    status: "Upcoming",
    id: 5,
  ),
];

String morningJoggingDescription =
    "Start your day with a burst of energy and positivity! "
    "Our Morning Jogging Session is perfect for fitness enthusiasts and beginners alike. "
    "Enjoy the serene beauty of Central Park while you jog at your own pace.\n\n"
    "🌟 Event Highlights:\n"
    "- A refreshing route through the park.\n"
    "- Guidance from experienced joggers.\n"
    "- Networking opportunities with fellow participants.\n"
    "- Hydration stations and light refreshments provided.\n\n"
    "📅 Date: 2024-11-23\n"
    "📍 Location: Central Park, New York\n\n"
    "Join us to jumpstart your day with health, happiness, and new connections. "
    "Sign up now and be part of this rejuvenating experience!";

String eveningYogaDescription =
    "Unwind and recharge your soul with our Evening Yoga Session by the beach. "
    "Relax your body, calm your mind, and soak in the tranquil atmosphere of Sunset Beach.\n\n"
    "🌟 Event Highlights:\n"
    "- Guided yoga and meditation sessions.\n"
    "- A beautiful sunset backdrop.\n"
    "- Perfect for all experience levels.\n"
    "- Complimentary yoga mats and refreshments.\n\n"
    "📅 Date: 2024-11-25\n"
    "📍 Location: Sunset Beach, California\n\n"
    "Don’t miss this opportunity to find inner peace and serenity. "
    "Reserve your spot today and embrace relaxation like never before!";

String cyclingMarathonDescription = "Gear up for an exhilarating adventure! "
    "Our Cycling Marathon is designed for riders of all skill levels, from beginners to pros. "
    "Enjoy the stunning views of Golden Gate Park as you race to the finish line.\n\n"
    "🌟 Event Highlights:\n"
    "- Scenic and challenging cycling routes.\n"
    "- Exciting prizes for top finishers.\n"
    "- Support stations throughout the track.\n"
    "- Post-race celebrations and networking.\n\n"
    "📅 Date: 2024-11-30\n"
    "📍 Location: Golden Gate Park, San Francisco\n\n"
    "Join us for an unforgettable cycling experience. "
    "Register now to secure your place in this thrilling event!";

String cleanupDriveDescription =
    "Make a positive impact in your community by joining our Cleanup Drive! "
    "Let’s come together to create a cleaner and healthier environment for everyone.\n\n"
    "🌟 Event Highlights:\n"
    "- Cleanup supplies and tools provided.\n"
    "- Fun team-building activities.\n"
    "- Educational talks on environmental conservation.\n"
    "- Refreshments for all participants.\n\n"
    "📅 Date: 2024-12-02\n"
    "📍 Location: Downtown Plaza, Chicago\n\n"
    "Be the change you wish to see in the world. "
    "Sign up today and contribute to a greener future!";

String techTalkDescription =
    "Dive into the fascinating world of Artificial Intelligence at our Tech Talk event! "
    "Discover how AI is shaping the future and transforming industries worldwide.\n\n"
    "🌟 Event Highlights:\n"
    "- Keynote sessions by AI experts.\n"
    "- Insightful panel discussions.\n"
    "- Networking opportunities with industry leaders.\n"
    "- Live demonstrations of cutting-edge AI applications.\n\n"
    "📅 Date: 2024-12-05\n"
    "📍 Location: Tech Innovation Hub, Seattle\n\n"
    "Don’t miss this chance to explore the future of technology. "
    "Register today to secure your spot at this inspiring event!";

var fakeCommentListResponse = {
  "status": "success",
  "data": [
    {
      "id": 1,
      "isMine": true,
      "teacherName": "Subrata Jana",
      "comment":
          "This is the first comment from me and it is feeling awesome to post a comment in this app and all the developers are awesome here. They have great Technical skills and are very proficient in their domain.",
      "nameInitial": "SJ",
      "userImage":
          "https://img.favpng.com/21/21/12/industry-user-experience-korskyrkan-rebro-lorem-ipsum-is-simply-dummy-text-of-the-printing-png-favpng-tgtynPexwfR1JhuQyzfwtVguC.jpg",
    },
    {
      "id": 2,
      "isMine": false,
      "teacherName": "Manish Pandey",
      "comment":
          "This is fantastic work! Keep it up. Really appreciate your effort. I hope to see you soon in real.",
      "nameInitial": "SJ",
      "userImage":
          "https://monirakandha.com/personal/wp-content/uploads/2020/04/www.themezaa.com189image-2.jpg",
    },
    {
      "id": 3,
      "isMine": false,
      "teacherName": "Sagar KC",
      "comment":
          "I think this could be improved in some areas, but overall, a great job!",
      "nameInitial": "SJ",
      "userImage": "https://www.themezaa.com/html/pofo/images/image-7.jpg",
    },
    {
      "id": 4,
      "isMine": true,
      "teacherName": "Subrata Jana",
      "comment":
          "Great job! The presentation was clear and concise. Looking forward to your next update.",
      "nameInitial": "SJ",
      "userImage":
          "https://img.favpng.com/21/21/12/industry-user-experience-korskyrkan-rebro-lorem-ipsum-is-simply-dummy-text-of-the-printing-png-favpng-tgtynPexwfR1JhuQyzfwtVguC.jpg",
    },
    {
      "id": 5,
      "isMine": true,
      "teacherName": "Subrata Jana",
      "comment":
          "This project demonstrates a high level of dedication and attention to detail. \nThe way you’ve organized and structured the information is impressive. \nWith a few minor adjustments, this could become a benchmark for others to follow.",
      "nameInitial": "SJ",
      "userImage":
          "https://img.favpng.com/21/21/12/industry-user-experience-korskyrkan-rebro-lorem-ipsum-is-simply-dummy-text-of-the-printing-png-favpng-tgtynPexwfR1JhuQyzfwtVguC.jpg",
    },
    {
      "id": 6,
      "isMine": false,
      "teacherName": "Dheraj Sharma",
      "comment":
          "Excellent work on tackling this complex problem! \nYou’ve showcased both innovation and practicality in your approach. \nI’m excited to see how this evolves in the coming stages with further refinement.",
      "nameInitial": "SJ",
      "userImage": "https://www.themezaa.com/html/pofo/images/blog-img103.jpg",
    },
    {
      "id": 7,
      "isMine": false,
      "teacherName": "Sagar KC",
      "comment":
          "I think this could be improved in some areas, but overall, a great job!",
      "nameInitial": "SKC",
      "userImage": "https://www.themezaa.com/html/pofo/images/blog-img101.jpg",
    },
  ]
};
