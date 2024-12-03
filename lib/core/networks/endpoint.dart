class Endpoints {
  static const baseUrl = 'http://3.109.108.92/api/teacher/';

  // static const baseUrl = 'https://1b16-115-96-137-46.ngrok-free.app/api/teacher/';

  //Authentication
  static const login = 'login/';
  static const signupPhase1 = 'registerFirstStep';
  static const signupPhase2 = 'registerSecondStep';
  static const signupPhase3 = 'registerThirdStep';

  //Activity
  static const createActivity = 'createActivity';
  static const uploadImage = 'upload/activity';
  static const fetchActivityList = 'fetchActivityList';
  static const fetchCommentList = 'fetchCommentListByActivityId/';
  static const fetchDropdownList = 'fetchActivityTypeDropdown';

  //Profile
  static const uploadProfilePicture = 'upload/profile-picture';
  static const fetchProfileDetails = 'fetchProfileDetails';
  static const updateProfile = 'updateProfile';
}
