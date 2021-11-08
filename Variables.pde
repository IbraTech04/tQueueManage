int[] colors = {50, 130, 184, 128, 0, 0, 92, 153, 107}, textColor = {255, 255, 255}, backGroundColor = {0, 0, 0};
int colorShift = 0, tet = 0, ishift = 0;
int[] newColors = {50, 130, 184}, newBG = {0, 0, 0}, newText = {0, 0, 0};
int startupState = 0, screenNumber = 1, delay = 0, picSize = 1000, state = 0;
float textScale = 1, subTitle = 0, picScale = 1, alpha = 0, alphaLoadingScreen = 255, alphaEaster = 0, alphaLicence=0, alphaCheck = 255, picCol = 255;
int newPicCol = 255;
boolean tmSyncc = true, offlineMode = true, syncServerStat = false, errorStat = true, adminMode = false, adminCommands = false, imagedraw = false, syncSendStat = false; 
boolean easterEggStat = false, fadeOut = false, isSetup, activated = false;
boolean active = false, active2 = false, legacyStat = false, customTheme = false, needReboot, licenceDisabled = false;
PImage[] loadingAnimation = new PImage[192];
int textState = 0, numDrives = 0;
int minDelta = 5000, currentDelta = 0, adminDelta, maxAdminDelta = 250, tSyncDelta;
boolean addToDelta = false, tooFast = false, niceTry = false, adminError = false, tSyncError;
PImage logo;
PImage homep, settingsp, editor;

color sideBar, bg, text;

int lang = 0;

float transSpeed = 2.5;

String[] topTextHome = {"tQMe Home", "الشاشة الرئيسية"};
String[] topTextSettings = {"tQMe Settings", "إعدادات تمكم"};
String[] topTextTheme = {"tQMe Theme Editor", "محرر ألوان تمكم"};
String[] settingBottomText = {"Settings in this color can only be changed in Preferences.tQMe\nPress R to reload tQMe for settings in this color to take effect. Press F to perform a Factory Reset", "لا يمكن تغيير الإعدادات بهذا اللون إلا في Preferences.tQMe ، ويمكن العثور على بعض الإعدادات فقط في Preferences.tQMe \n اضغط على R لإعادة تحميل تمكم للإعدادات بهذا اللون لتصبح سارية المفعول \n اضغط F لإجراء إعادة تعيين"};

PrintWriter Licence, Pref, cTheme;

/*
0 = Loading
 1 = Main Screen
 2 = GUI Settings
 3 = First Time Setup
 4 = Error Screen
 */
String licenceOwner, uName = "", pKey = "", pID = "", UDPIP, Theme, cScheme, TMSyncc;
PFont font, boldFont;
int shiftRegister = 0, UDPPort;

String [] pref, cusTheme, COLOR;

void reset(boolean resetLicence) {
  eL0 = null;
  eL1 = null;
  adminDelta = 0;
  numDrives = 0;
  tet = 0;
  startupState = 0; 
  screenNumber = 1;
  delay = 0;
  picSize = 1000;
  state = 0;
  textScale = 1; 
  subTitle = 0; 
  picScale = 1; 
  alpha = 0; 
  alphaLoadingScreen = 255; 
  alphaEaster = 0; 
  alphaLicence=0; 
  alphaCheck = 255;
  tmSyncc = true; 
  offlineMode = false; 
  syncServerStat = false; 
  errorStat = false; 
  adminMode = false; 
  adminCommands = false; 
  imagedraw = false; 
  syncSendStat = false; 
  easterEggStat = false; 
  fadeOut = false; 
  activated = true;
  active = true; 
  active2 = true; 
  legacyStat = false;
  licenceDisabled = false;
  uName = "";
  pKey = "";
  udp.close();
  queue.names.clear();
  if (resetLicence) {
    Theme = "Dark";
    cScheme = "Blue";
    UDPIP = "224.0.1.1";
    UDPPort = 6000;
    TMSyncc = "On";
    updateFile();
    isSetup = false;
    activated = false;
    active = false; 
    active2 = false; 
    Licence = createWriter("data/ActivationInfo.tQMe");
  }
  adminError = false;
  setup();
}


String getUserName() {
  String fullName;
  try {
    fullName = Secur32Util.getUserNameEx(Secur32.EXTENDED_NAME_FORMAT.NameDisplay);
  }

  catch (Exception e) {
    fullName = System.getProperty("user.name");
  }

  return(fullName);
}
