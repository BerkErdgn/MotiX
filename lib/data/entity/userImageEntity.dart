
class UserImageEntity{
  String userId;
  String userName;
  String userEmail;
  String profileIcon;

  UserImageEntity({required this.userId,required this.userName,required this.userEmail,required this.profileIcon});

  factory UserImageEntity.fromJson(Map<dynamic,dynamic> json,String key){
    return UserImageEntity(
        userId: key,
        userName: json ["userName"] as String? ?? '',
        userEmail: json ["userEmail"] as String? ?? '',
        profileIcon: json ["profileIcon"] as String? ?? ''
    );
  }
}