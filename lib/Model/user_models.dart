class User {
  int? id;
  String username = "";
  String emailaddress = "";
  String image = "";
  String password = "";
  String role = ""; // Nouveau champ pour le rôle de l'utilisateur
  String? accessCode; // Champ pour le code d'accès, nullable

  User({
    this.id,
    required this.username,
    required this.image,
    required this.emailaddress,
    required this.password,
    required this.role, // Ajout du rôle dans le constructeur
    this.accessCode, // Ajout du code d'accès dans le constructeur
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'],
      username: map['name'],
      image: map['profil_img'],
      emailaddress: map['email'],
      password: map['password'],
      role: map['role'],
      accessCode: map['role'] == 'secretaire' ? map['access_code'] : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': id,
      'name': username,
      'profil_img': image,
      'email': emailaddress,
      'password': password,
      'access_code': role == 'secretaire' ? accessCode : null,
    };
  }
}
