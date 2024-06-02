class User {
  constructor(userName, password, userEmail, isAdmin, isAuthUser, isManagement, isItSupport) {
    this.userName = userName;
    this.password = password;
    this.userEmail = userEmail;
    this.isAdmin = isAdmin;
    this.isAuthUser = isAuthUser;
    this.isManagement = isManagement;
    this.isItSupport = isItSupport;
  }
}

module.exports = User;
