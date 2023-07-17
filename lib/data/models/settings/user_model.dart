class UserModel{
  final String?userName;
  final String?email;
  final String?token;
  final String?accessToken;
  final String?photoUrl;
  final String?phoneNumber;


  UserModel({
    this.userName,
    this.email,
    this.token,
    this.accessToken,
    this.phoneNumber,
    this.photoUrl});

  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        photoUrl: json['photoUrl'],
        userName: json['userName'],
        email: json['email'],
        accessToken: json['accessToken'],
        phoneNumber: json['phoneNumber'],
        token: json['token']
    );
  }

  Map<String,dynamic>toJson(){
    return {
      "userName":userName,
      "email":email,
      "phoneNumber":phoneNumber,
      "token":token,
      "accessToken":accessToken,
      "photoUrl":photoUrl


    };
  }

}