enum Pages {
  signIn,
  signUp,
  passwordReset,
  sendCode,
  projects,
  addProject,
  updateProject,
  jobs,
  addJob,
  updateJob,
}

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.signIn => '/',
      Pages.signUp => 'signUp',
      Pages.sendCode => 'sendCode',
      Pages.passwordReset => 'passwordReset',
      Pages.projects => '/projects',
      Pages.addProject => 'addProject',
      Pages.updateProject => 'updateProject',
      Pages.jobs => '/jobs',
      Pages.addJob => 'addJob',
      Pages.updateJob => 'updateJob',
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
      Pages.updateProject => 'UPDATEPROJECT',
      Pages.jobs => 'JOBS',
      Pages.addJob => 'ADDJOB',
      Pages.updateJob => 'UPDATEJOB',
    };
  }
}
