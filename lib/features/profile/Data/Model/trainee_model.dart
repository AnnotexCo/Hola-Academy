class AllUsersModel {
  AllUsersModel({
    required this.message,
    required this.totalDocs,
    required this.data,
  });
  late final String message;
  late final int totalDocs;
  late final Data data;
  
  AllUsersModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    totalDocs = json['totalDocs'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['totalDocs'] = totalDocs;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.totalDocs,
    required this.count,
    required this.users,
  });
  late final int totalDocs;
  late final int count;
  late final List<Users> users;
  
  Data.fromJson(Map<String, dynamic> json){
    totalDocs = json['totalDocs'];
    count = json['count'];
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalDocs'] = totalDocs;
    _data['count'] = count;
    _data['users'] = users.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Users {
  Users({
    required this.email,
    required this.name,
    required this.gender,
    required this.dob,
    required this.parentName,
    required this.phoneNumber,
    required this.parentWhatsappNumber,
    required this.role,
     this.profileImage,
  });
  late final String email;
  late final String name;
  late final String gender;
  late final String dob;
  late final String parentName;
  late final String phoneNumber;
  late final String parentWhatsappNumber;
  late final String role;
  late final ProfileImage? profileImage;
  
  Users.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    parentName = json['parentName'];
    phoneNumber = json['phoneNumber'];
    parentWhatsappNumber = json['parentWhatsappNumber'];
    role = json['role'];
    profileImage = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['name'] = name;
    _data['gender'] = gender;
    _data['dob'] = dob;
    _data['parentName'] = parentName;
    _data['phoneNumber'] = phoneNumber;
    _data['parentWhatsappNumber'] = parentWhatsappNumber;
    _data['role'] = role;
    _data['ProfileImage'] = profileImage;
    return _data;
  }
}

class ProfileImage {
  ProfileImage({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String path;
  late final String type;
  late final int size;
  late final bool isDeleted;
  late final String createdAt;
  late final String updatedAt;
  
  ProfileImage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    path = json['path'];
    type = json['type'];
    size = json['size'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['path'] = path;
    _data['type'] = type;
    _data['size'] = size;
    _data['isDeleted'] = isDeleted;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}