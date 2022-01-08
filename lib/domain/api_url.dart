class Api {
  Api._();
  static const String domain = "https://stage.employeeapis.emptra.com";
  static const String register = "https://stage.employeeapis.emptra.com/register";

  // LIST GET
  static const String getEmployee = "https://stage.employeeapis.emptra.com/employee";
  static const String instituteList = "https://stage.employeeapis.emptra.com/insititue";
  static const String industryList = "https://stage.employeeapis.emptra.com/getIndustries";
  static const String countryList = "https://stage.employeeapis.emptra.com/countries";
  static const String educationHistoryList = "https://stage.employeeapis.emptra.com/getEducationHistory";
  static const String employmentHistoryList = "https://stage.employeeapis.emptra.com/getEmploymentHistory";
  static const String courseHistoryList = "https://stage.employeeapis.emptra.com/getCourses";
  static const String vehicleHistoryList = "https://stage.employeeapis.emptra.com/getVehicleVerification";
  static const String addressList = "https://stage.employeeapis.emptra.com/getPhysicalVerification";
  static const String certificateHistoryList = "https://stage.employeeapis.emptra.com/getCertificate";
  static const String vaccineHistoryList = "https://stage.employeeapis.emptra.com/getVaccine";
  static const String getRtpcr = "https://stage.employeeapis.emptra.com/getRtPcr";
  static const String helpHistoryList = "https://stage.employeeapis.emptra.com/getHelpStats";
  static const String vehicleList =  "https://stage.employeeapis.emptra.com/getVehicleVerification";
  static const String skillsList = "https://stage.employeeapis.emptra.com/getIndustrySkills";
  static const String employeeCountry = "https://stage.employeeapis.emptra.com/getEmployeeCountry";
  static const String interestsList = "https://stage.employeeapis.emptra.com/getInterests";
  static const String physicalBody = "https://stage.employeeapis.emptra.com/getPhysicalBodyVerification";
  static const String photosList = "https://stage.employeeapis.emptra.com/getPhotos";
  static const String videoList = "https://stage.employeeapis.emptra.com/getVideos";
  static const String bmi = "https://stage.employeeapis.emptra.com/getBmi";
  static const String socialScore = "https://stage.employeeapis.emptra.com/socialScore";
  static const String learningScore = "https://stage.employeeapis.emptra.com/learningScore";
  static const String etScore = "https://stage.employeeapis.emptra.com/etScore";
  static const String getEmailVerify = "https://stage.employeeapis.emptra.com/getEmailVerificationDetails";

  static const String creditScore = "https://stage.employeeapis.emptra.com/userCredits/getPlan";

  static const String healthScore = "https://stage.employeeapis.emptra.com/healthScore";
  static const String getBankDetails = "https://stage.employeeapis.emptra.com/verification/getBankDetails";
  static const String getAdhaarDetails = "https://stage.employeeapis.emptra.com/getGovtDocs";
  static const String getPenDetails = "https://stage.employeeapis.emptra.com/getGovtDocs";
  static const String getAllHrDetails = "https://stage.employeeapis.emptra.com/userHrDetails";
  static const String getEmailDetails = "https://stage.employeeapis.emptra.com/getEmailVerificationDetails";

  // API POST
  static const String profileInfo = "https://stage.employeeapis.emptra.com/employee";
  static const String getCredit = "https://stage.employeeapis.emptra.com/userCredits/getPlan";

  static const String login = "https://stage.usermgtapis.emptra.comauthenticate";
  static const String checkPhone = "https://stage.integrationapis.emptra.com/checkMobile";
  static const String sendOtp = "https://stage.integrationapis.emptra.com/login/sendOtp";
  static const String addPhysicalbody = "https://stage.employeeapis.emptra.com/physicalBodyVerification";
  static const String standardPlan = "http://stage.employeeapis.emptra.com/userCredits/buyPlan";
  static const String premiumPlan = "http://stage.employeeapis.emptra.com/userCredits/buyPlan";
  static const String orderId = "https://stage.integrationapis.emptra.com/payment/order";
  static const String addAmount = "http://stage.employeeapis.emptra.com/userPaymentDetails";
  static const String sendTruLink = "https://stage.employeeapis.emptra.com/truLink";
  static const String hrDetail = "https://stage.employeeapis.emptra.com/hrStatus";
  static const String verifyOtp = "https://stage.integrationapis.emptra.com/login/verifyOtp";
  static const String verifyLogin = "https://stage.integrationapis.emptra.com/login/verifyOtp";
  static const String verifyEmail = "https://stage.employeeapis.emptra.com/emailVerification";
  static const String companyName = "https://api.finanvo.in/search/company?query=";
  static const String getcompanyName = "https://stage.employeeapis.emptra.com/getEmploymentHistory";
  //DigiLocker APi
  static const String digiLocker = "https://stage.veapis.emptra.com/verification/automation";
  static const String digiLockersync = "https://stage.integrationapis.emptra.com/digilocker/syncMobile";


  // DELETE
  static const String deleteEmployement = "https://stage.employeeapis.emptra.com/removeEmploymentHistory";
  static const String deleteEducation = "https://stage.employeeapis.emptra.com/removeEducationHistory";
  static const String deleteVaccine = "https://stage.employeeapis.emptra.com/removeVaccine";
  static const String deleteCourse = "https://stage.employeeapis.emptra.com/removecourses";
  static const String deleteCertifcate = "https://stage.employeeapis.emptra.com/removeCertificates";
  static const String deleteSocial = "https://stage.employeeapis.emptra.com/removeHelpStats";
  static const String deleteVehicle = "https://stage.employeeapis.emptra.com/removeVehicle";
  static const String deleteSkills = "https://stage.employeeapis.emptra.com/removeIndustrySkills";
  static const String deleteCountry = "https://stage.employeeapis.emptra.com/removeEmployeeCountry";
  static const String deleteProfile = "https://stage.employeeapis.emptra.com/removeData";

  // ADD POST
  static const String addemployment = "https://stage.employeeapis.emptra.com/update/profile";
  static const String addCourse = "https://stage.employeeapis.emptra.com/addCourses";
  static const String addCertificate = "https://stage.employeeapis.emptra.com/addCertificates";
  static const String addVaccine = "https://stage.employeeapis.emptra.com/addVaccine";
  static const String addRtPcr = "https://stage.employeeapis.emptra.com/addRtPcr";
  static const String addBmi = "https://stage.employeeapis.emptra.com/addBmi";
  static const String addeducationHistory = "https://stage.employeeapis.emptra.com/addEducationHistory";
  static const String addVehicle = "https://stage.employeeapis.emptra.com/vehicleVerification";
  static const String addAddress = "https://stage.employeeapis.emptra.com/physicalVerification";
  static const String addCompany = "https://stage.employeeapis.emptra.com/addIndustry";
  static const String addInstitute = "https://stage.employeeapis.emptra.com/addInstitute";
  static const String addIndustry = "https://stage.employeeapis.emptra.com/addIndustry";
  static const String addEmployment = "https://stage.employeeapis.emptra.com/addEmploymentHistory/";
  static const String addHelp = "https://stage.employeeapis.emptra.com/addHelpStats";
  static const String addSkills = "https://stage.employeeapis.emptra.com/addIndustry";
  static const String addCountries = "https://stage.employeeapis.emptra.com/employeeCountry";
  static const String addInterest = "https://stage.employeeapis.emptra.com/addInterest";
  static const String addVideos = "https://stage.employeeapis.emptra.com/addVideos";
  static const String addPhotos = "https://stage.employeeapis.emptra.com/addImages";
  static const String uploaddoc = "https://stage.veapis.emptra.com/verification/manual";
  static const String addGovermentDoc = "https://stage.veapis.emptra.com/verification/govtDocs";
  static const String addHr = "https://stage.veapis.emptra.com/verification/initiateHrVerification";
  static const String addBank = "https://stage.integrationapis.emptra.com/bank-account/verify";

  // ADD UPDATE
  static const String updateEmployment = "https://stage.employeeapis.emptra.com/updateEmploymentHistory";
  static const String updateEducation = "https://stage.employeeapis.emptra.com/updateEducationHistory";
  static const String updateProfile = "https://stage.employeeapis.emptra.com/update/profile";

}