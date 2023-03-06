class Quse {
  static const ques1 = "CODE D.C는 어떤 동아리인가요?";
  static const ques2 = "전공에 대한 지식이 없어도 괜찮을까요?";
  static const ques3 = "노트북이 필요한가요?";
  static const ques4 = "동아리에서는 주로 무슨 활동을 하나요?";
  static const ques5 = "모집 인원은 몇 명인가요?";

  static const ans1 = "CODE D.C 는 개발 동아리로 웹, 앱, 등 개발과 관계있는 여러 분야를 공부하고 있습니다.";
  static const ans2 = "괜찮습니다! 실력보다는 성실성과 인성을 주로 보기에 부담가지지 마시고 지원하시면 됩니다.";
  static const ans3 = "활동에 있어서 있으면 좋겠지만 지금 당장은 없어도 상관없습니다.";
  static const ans4 = "기초적인 기량을 올린 이후에는 주로 교내에 도움될만한 프로젝트 혹은 대회에 참여하고 있습니다.";
  static const ans5 = "모집인원은 따로 정해져 있지 않습니다. 따라서 유동적으로 바뀔 수 있습니다.";

  question() {
    List<String> ques = [ques1, ques2, ques3, ques4, ques5];
    return ques;
  }

  answer() {
    List<String> ans = [ans1, ans2, ans3, ans4, ans5];
    return ans;
  }
}

class Award {
  static Map year_2017 = {
    "year": 2017,
    "award": [
      "STAC 2017 생활부문 가작",
      "STAC 2017 IoT부문 가작",
      "제 1회 세브란스병원 빅데이터 공모전 우수상",
      "한세자랑 홍보작품 공모전 APP 금상",
      "창의아이디어 경진대회 대상"
    ]
  };
  static Map year_2018_1 = {
    "year": 2018,
    "award": [
      "전국 ICT창의성대회 동상",
      "서강대 알고리즘 본선 진출",
      "메이커톤 대상",
      "해커해커톤 대상",
      "AngelHackathon 대상",
    ]
  };
  static Map year_2018_2 = {
    "year": 2018,
    "award": [
      "System32 WarGame 1등",
      "제 1회 한세톤 생활부문 우수상",
      "한세의 민족 개발",
      "X2O 소셜 해커톤 대회 혁신상"
    ]
  };
  static Map year_2019 = {
    "year": 2019,
    "award": ["AngelHack IBM챌린지 우승", "한빛사이트 개발", "한세멜론 개발", "페이시스템 개발"]
  };
  static Map year_2021 = {
    "year": 2021,
    "award": ["한빛v2 개발", "한국코드페어 금상(장관상)"]
  };
  static Map year_2022 = {
    "year": 2022,
    "award": ["STAC 생활 정보 부문 우수상"]
  };
  AllAward() {
    List<Map> ang = [
      year_2017,
      year_2018_1,
      year_2018_2,
      year_2019,
      year_2021,
      year_2022
    ];
    return ang;
  }
}
