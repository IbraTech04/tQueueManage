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
int minDelta = 5000, currentDelta = 0, adminDelta, maxAdminDelta = 250;
boolean addToDelta = false, tooFast = false, niceTry = false;
PImage logo;
PImage homep, settingsp, editor;

color sideBar, bg, text;

int lang = 0;

float transSpeed = 2.5;

String[] topTextHome = {"TMQM Home", "الشاشة الرئيسية"};
String[] topTextSettings = {"TMQM Settings", "إعدادات تمكم"};
String[] topTextTheme = {"TMQM Theme Editor", "محرر ألوان تمكم"};
String[] settingBottomText = {"Settings in this color can only be changed in Preferences.tmqm, and some settings can only be found in Preferences.tmqm \n Press R to reload TMQM for settings in this color to take effect \n Press F to perform a Factory Reset", "لا يمكن تغيير الإعدادات بهذا اللون إلا في Preferences.tmqm ، ويمكن العثور على بعض الإعدادات فقط في Preferences.tmqm \n اضغط على R لإعادة تحميل تمكم للإعدادات بهذا اللون لتصبح سارية المفعول \n اضغط F لإجراء إعادة تعيين"};

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
    isSetup = false;
    activated = false;
    active = false; 
    active2 = false; 
    Licence = createWriter("data/ActivationInfo.tmqm");
  }
  setup();
}
