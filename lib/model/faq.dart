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
