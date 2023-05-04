import '../models/auth/detail_listing_model.dart';
import '../views/auth/professionDetail/training/training_page.dart';

class AppConstant {
  static const signupAsCustomer = "sign up as employer";
  static const providePersonalDetails = "Provide Personal Details";
  static const certificate = "Provide your certification";
  static const hereyourLatestUpdate = "HERE ARE YOUR LASTEST UPDATES";
  static const updateMyDocument = "Update my documents";
  static const documentReq = "Document Required";
  static const profileMissing = "Your profile is missing some documents.";

  //location details screen constant
  static const updateNotification = "Update Notification";
  static const locationDoesnotHaveShifts =
      '''This care location doesn't have any available shifts.Review your notifications to make sure you get an alert next time they post a shift.''';

  static const howTofindHome = "How to find the home";
  static const getDirection = "Get Direction";
  //filter screen
  static const whatDaysOfWeek = "On what days of the week";
  static const minmumrate = "What’s your minimum hourly rate  ?";
  static const travelWilling = "How far are you willing to travel ?";
  static const whichRoleWork = "which role do you want to work ?";
  static const whichShiftPref = "which shifts do you prefer to work ?";

  ///shift detail screen
  static const safetyGuideLine = "Safety guidelines for this shift";
  static const addToCalender = "Add to calendar";
  static const shiftDetails = "Shift details";
  static const unitName = "Unit name";
  static const aboutHome = "About the home";
  static const shiftAttribute = "Shift attributes";
  static const rating = "Rating";
  static const realibality = "Reliability (last 3 months)";
}

const avtarImage = "https://i.pravatar.cc/150?img=21";
final List<ProfessionDetailsModel> professionalListing = [
  ProfessionDetailsModel(
    name: "Personal Details",
    percent: 0,
    id: 1,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "Training",
    percent: 0,
    id: 2,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "Work History",
    percent: 0,
    id: 3,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "References",
    percent: 0,
    id: 4,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "Getting paid",
    percent: 0,
    id: 5,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "Background Checks",
    percent: 0,
    id: 6,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "ID Badge",
    percent: 0,
    id: 7,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "NMC",
    percent: 0,
    id: 8,
    isCompelete: false,
  ),
  ProfessionDetailsModel(
    name: "Next of Kin",
    percent: 0,
    id: 9,
    isCompelete: false,
  ),
];
const awsacces = "AKIAYDLF6W5K3EH3IPMT";
const secretAccessKey = "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";
List<CertificateModel> certificationList = [
  CertificateModel(
    id: 1,
    isUploaded: false,
    name: "Medication Adminstrator",
  ),
  CertificateModel(
    id: 2,
    isUploaded: false,
    name: "Manual Handling ",
  ),
  CertificateModel(
    id: 3,
    isUploaded: false,
    name: "Helathy & Safety",
  ),
  CertificateModel(
    id: 4,
    isUploaded: false,
    name: "Infection Control",
  ),
  CertificateModel(
    id: 5,
    isUploaded: false,
    name: "Life Support",
  ),
  CertificateModel(
    id: 6,
    isUploaded: false,
    name: "First Aid",
  ),
  CertificateModel(
    id: 7,
    isUploaded: false,
    name: "Fire Safety",
  ),
  CertificateModel(
    id: 8,
    isUploaded: false,
    name: "Information Goverance",
  ),
  CertificateModel(
    id: 9,
    isUploaded: false,
    name: "Mental Capacity Act",
  ),
  CertificateModel(
    id: 10,
    isUploaded: false,
    name: "Safeguarding Adults level 1(Adult Support and protection)",
  ),
  CertificateModel(
    id: 11,
    isUploaded: false,
    name: "Medication Competency Assetment",
  ),
  CertificateModel(
    id: 12,
    isUploaded: false,
    name: "Understanding learning disabilities and Autistic Spectrum Disorder",
  ),
];
