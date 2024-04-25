enum Pages { signIn, signUp, passwordReset, sendCode, projects, addProject, editProject }

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.signIn => '/',
      Pages.signUp => 'signUp',
      Pages.sendCode => 'sendCode',
      Pages.passwordReset => 'passwordReset',
      Pages.projects => '/projects',
      Pages.addProject => 'addProject',
      Pages.editProject => 'editProject',
    };
  }

  String get screenName {
    return switch (this) {
      Pages.signIn => 'SIGNIN',
      Pages.signUp => 'SIGNUP',
      Pages.sendCode => 'SENDCODE',
      Pages.passwordReset => 'PASSWORDRESET',
      Pages.projects => 'PROJECTS',
      Pages.addProject => 'ADDPROJECT',
      Pages.editProject => 'EDITPROJECT',
    };
  }
}
