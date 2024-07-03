
class  SavedUser{
  String userId;
  String userName;
  String userEmail;
  String profileIcon;

  SavedUser({required this.userId,required this.userName,required this.userEmail,required this.profileIcon});

  factory SavedUser.fromJson(Map<dynamic,dynamic> json){
    return SavedUser(
        userId: json ["userId"] as String,
        userName: json ["userName"] as String,
        userEmail: json ["userEmail"] as String,
        profileIcon: json ["profileIcon"] as String
    );
  }
}