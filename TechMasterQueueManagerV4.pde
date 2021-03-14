//The Main GUI Screen and Drawing Functions
import java.util.Calendar; //Import Calendar Functions
import uibooster.*;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;
import hypermedia.net.*;
UDP udp;

DisposeHandler dh;

List queue;

import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;  

import uibooster.*;
UiBooster booster;

boolean isConfirmed;

import processing.sound.*; //Sounds! Cause why not?
SoundFile Error, newEntry, Clear, devCon, devDis, syncCon, syncDis, startup; 

void setup() {
  background(0, 0, 0);
  logo = loadImage("logo.png");
  imageMode(CENTER);
  image(logo, width/2, height/2, 1000, 1000);
  SmoothCanvas sc = (SmoothCanvas) getSurface().getNative();
  JFrame jf = (JFrame) sc.getFrame();
  Dimension d = new Dimension(1280, 720);
  jf.setMinimumSize(d);
  getSurface().setResizable(true);
  size(1280, 720);
  booster = new UiBooster();
  queue = new List();
  queue.names = new StringList();
  queue.currentName = "";
  dh = new DisposeHandler(this);
  fill(textColor[0], textColor[1], textColor[2]);
  textAlign(CENTER);
  textSize(50);
  homep[0] = loadImage("HomeL.png");
  homep[1] = loadImage("Home.png");
  settingsp[0] = loadImage("SettingsL.png");
  settingsp[1] = loadImage("Settings.png");
  editor[0] = loadImage("EditorL.png");
  editor[1] = loadImage("Editor.png");
  ultraProtecc();
  loadPreferences();
  booster = new UiBooster();
  smooth();
  font = createFont("Product Sans.ttf", 100);
  boldFont = createFont("Product Sans Bold.ttf", 100);
  Error = new SoundFile(this, "Error.mp3");
  newEntry = new SoundFile(this, "Tada.wav");
  Clear = new SoundFile(this, "Rec.mp3");
  devCon = new SoundFile(this, "devCon.wav");
  devDis = new SoundFile(this, "devDis.wav");
  syncCon = new SoundFile(this, "syncCon.wav");
  syncDis = new SoundFile(this, "syncDis.wav");
  startup = new SoundFile(this, "startup.wav");
  surface.setTitle("QueueManage!");
  surface.setResizable(true); 
  noStroke();
  udp = new UDP( this, UDPPort, UDPIP);
  udp.listen( true );
  udp.send("Starting");
  startup.play();
}

void draw() {
  if (!syncSendStat) {
    syncSendStat = true;
    udp.send("Init");
  }    
  if (startupState == 0) {
    background(0, 0, 0);
    tint(picCol, alphaLoadingScreen);
    image(logo, width/2, height/2, picSize, picSize);
    fadeOut(15, "load");
    if (alphaLoadingScreen <= 0) {
      if (licenceDisabled) {
        startupState = 5;
      } else if (activated) {
        startupState = 1;
      } else {
        if (isSetup) {
          startupState = 2;
        } else {
          startupState = 3;
        }
      }
    }
  } else if (easterEggStat) {
    easterEgg();
  } else if (startupState == 1) {
    noStroke();
    colorShift(newColors[0], newColors[1], newColors[2]);
    colorShiftBG(newBG[0], newBG[1], newBG[2]);
    colorShiftText(newText[0], newText[1], newText[2]);
    colorShiftImg(newPicCol);

    textFont(font, 25*textScale);
    tint(picCol, alpha);
    techMasterSizeDeteccV3();
    background(0, 0, 0);
    fill(backGroundColor[0], backGroundColor[1], backGroundColor[2], alpha);
    rect(0, 0, width, height);
    fill(colors[colorShift], colors[colorShift+1], colors[colorShift+2], alpha);
    fadeIn(20, "main");
    rect(0, height*0.102986612 - 1, width*0.05859375, height);
    rect(0, 0, width, height*0.102986612);
    image(homep[ishift], home[0], home[1], 50, 50);
    image(settingsp[ishift], settings[0], settings[1], 50, 50);
    image(editor[ishift], stats[0], stats[1], 50, 50);
    if (screenNumber == 1) {
      mainScreen();
    } else if (screenNumber == 2) {
      guiSettings();
    } else if (screenNumber == 3) {
      themeEditor();
    }
  } else if (startupState == 2) {
    invalidLicence();
  } else if (startupState == 3) {
    fTimeSetup();
  } else if (startupState == 4) {
    background(0);
    licenceCheck();
  } else if (startupState == 5) {
    licenceisCorrupt();
  }
}

void fTimeSetup() {
  background(0);
  tint(picCol, alphaLicence);
  fill(255, 255, 255, alphaLicence);
  fadeIn(15, "");
  pushMatrix();
  translate(0, 50);
  textFont(boldFont, 75);
  text("Welcome to TMQM V4!", width/2, height/2-200);
  textFont(boldFont, 45);    
  text("A new era of Queue Management!", width/2, height/2-150);
  textFont(font, 35);
  text("To continue, please enter your licence information", width/2, height/2-110);
  textFont(boldFont, 40);
  text("Username: " + uName, width/2, height/2-60);
  text("Product Key: " + pKey, width/2, height/2-10);
  textFont(boldFont, 30);
  text("Tip: You can copy and paste text into the licence screen now! Try it! ", width/2, height-60);

  popMatrix();
  if (state == 2) {
    writeLicence(false);
    ultraProtecc();
    startupState = 4;
  }
}

void licenceCheck() {
  tet++;
  background(0);
  textFont(boldFont, 50);
  fill(255, 255, 255, alphaCheck);
  if (tet >=0) {
    text("Validating Licence \n Please Wait", width/2, height/2);
  }
  if (tet >= 45) {
    background(0);
    if (activated) {
      text("Activation Successful! \n Welcome to TMQM!", width/2, height/2);
      if (tet >= 55) {
        fadeOut(15, "check");
        fadeOut(15, "main");
      }
      if (tet >= 70) {
        alpha=0;
        screenNumber = 1;
        startupState = 1;
        fadeIn(15, "main");
      }
    } else {
      startupState = 2;
    }
  }
}


void mainScreen() {
  state =4;
  noStroke();
  fill(textColor[0], textColor[1], textColor[2]);
  textFont(boldFont, 50);
  textAlign(LEFT);
  text(topTextHome[lang], 75, posName[1] -20);
  textFont(font, 25*textScale);
  text("Enter your name to reserve a spot", 400, posName[shiftRegister+1]-20);
  textFont(font, 25*textScale);
  if (adminMode) {
    text("Admin Mode Active", 80, height - 5);
  }
  if (errorStat) {
    fill(200, 25, 18);        
    textFont(font, 15*textScale);
    textAlign(LEFT);
    if (tmSyncc) {
      text("Error: It appears that TMShare is not \nworking properly. TMQM will continue in offline mode. \nTo fix this, try changing the UDP IP in Settings", width*0.05859375 + 5, 125);
    }
  }
  textAlign(RIGHT);
  if (offlineMode) {
    text("Offline Mode", width-10, height-10);
  } else if (syncServerStat) {
    text("TMSyncc Connected", width-10, height-10);
  } else {
    text("TMSyncc Not Connected", width-10, height-10);
    udp.send("waiting4Sync");
  }
  strokeWeight(5);
  editName();
  showNames();
}

void editName() {
  rectMode(CENTER);
  stroke(colors[colorShift], colors[colorShift+1], colors[colorShift+2], alpha);
  noFill();
  rect(posView[0], posView[1]-35, 335, 35);
  rectMode(CORNER);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  text(queue.currentName, posView[0], posView[1]-30);
}
//Shows the Queue (Thanks to Tiemen for the help with this part)
void showNames() {
  textAlign(LEFT);
  int namesPerColumn = round((height/2.5)/20);
  int yPos = 0;
  translate(width*0.05859375+15, 250);
  pushMatrix();
  for (int i = 0; i < queue.names.size(); i++) {
    yPos = (i % namesPerColumn) * 35;
    if (i != 0 && i % namesPerColumn == 0) {
      translate(250, 0);
    }
    String name = queue.names.get(i);
    textFont(boldFont, 25);
    text(name, 0, yPos);
  }
  popMatrix();
}
void easterEgg() {
  textFont(boldFont, 75*textScale);
  tint(picCol, alphaEaster);
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
  fadeIn(15, "2");
  pushMatrix();
  translate(0, 100);
  text("Credits:", width/2, height/2-240);
  textFont(font, 40*textScale);
  text("Lead Developer: Ibrahim Chehab", width/2, height/2-165);
  text("Lead Beta Tester: Maalik Khaial", width/2, height/2-120);
  text("Beta Tester: Fardeen Kasmani", width/2, height/2-75);
  text("Beta Tester: Ibrahim Qaiser", width/2, height/2-30);
  textFont(boldFont, 40*textScale);
  text("Press any key to return to TMQM", width/2, height/2+20);
  popMatrix();
  if (fadeOut) {
    fadeOut(15, "2");
    if (alphaEaster <=0) {
      easterEggStat = false;
      startupState = 1;
    }
  }
}

void licenceisCorrupt() {
  background(0);
  tint(picCol, alphaLicence);
  fill(255, 255, 255, alphaLicence);
  fadeIn(15, "");
  textFont(boldFont, 75);
  textAlign(CENTER);
  text("Uh oh, Invalid Licence", width/2, height/2-20);
  textFont(font, 30);
  text("It appears your TMQM licence has been deactivated. Please contact support", width/2, height/2+25);
}

void invalidLicence() {
  background(0);
  tint(picCol, alphaLicence);
  fill(255, 255, 255, alphaLicence);
  fadeIn(15, "");
  textFont(boldFont, 75);
  textAlign(CENTER);
  text("Uh oh, Invalid Licence", width/2, height/2-20);
  textFont(font, 30);
  text("It appears your TMQM licence has been altered, or is invalid.\n Press R now to restart into licence mode\nIf you need help, please contact support", width/2, height/2+25);
}

void guiSettings() {
  fill(textColor[0], textColor[1], textColor[2]);

  textFont(boldFont, 50*textScale);
  textAlign(LEFT);

  text(topTextSettings[lang], 75, posName[1] -20);
  textFont(font, 25*textScale);
  textAlign(LEFT);
  text("Customize it to your liking", 450, posName[shiftRegister+1]-20);
  textFont(boldFont, 50*textScale);
  textAlign(CENTER);

  text("Theme: " + Theme, width/2, themPos[0]);
  if (!customTheme) {
    if (Theme.equals("Really Dark")) {
      text("Color Scheme: Really Dark", width/2, clrPos[0]);
    } else if (Theme.equals("Really Light")) {
      text("Color Scheme: Really Light", width/2, clrPos[0]);
    } else {
      text("Color Scheme: " + cScheme, width/2, clrPos[0]);
    }
  } else {
    text("Color Scheme: Custom", width/2, clrPos[0]);
  }
  text("TMShare: " + TMSyncc, width/2, verbosePos[0]);
  fill(128, 128, 128);
  text("UDP Socket: " + UDPPort, width/2, UDPSPos[0]);
  text("UDP IP Address: " + UDPIP, width/2, UDPIPPos[0]);




  textFont(boldFont, 20*textScale);
  text(settingBottomText[lang], width/2+35, height-80);
}

void themeEditor() {
  noStroke();
  fill(textColor[0], textColor[1], textColor[2]);
  textFont(boldFont, 50);
  textAlign(LEFT);
  text(topTextTheme[lang], 75, posName[1] -20);
  textFont(font, 25*textScale);
  text("Customization like never before", 550, posName[shiftRegister+1]-20);
  textFont(boldFont, 40*textScale);
  textAlign(CENTER);

  text("Click on the background to set the background color", width/2, themPos[0]);
  text("Click on the top bar to set the color scheme", width/2, clrPos[0]);
  text("Press T on your keyboard to set the text color", width/2, verbosePos[0]);
  text("Use the UP and DOWN arrow keys to set the icon color", width/2, UDPSPos[0]);
  fill(128, 128, 128);
  textFont(boldFont, 20*textScale);

  text("Changing settings here will enable the custom theme and update the custom theme file", width/2+35, height-80);
}

void mousePressed() {
  if (mouseX >= 0 && mouseX <= 75) {
    if (mouseY >=home[1]-25 && mouseY <=home[1]+25) {
      screenNumber = 1;
    } else if (mouseY >=settings[1]-25 && mouseY <=settings[1]+25) {
      screenNumber = 2;
    } else if (mouseY >=stats[1]-25 && mouseY <=stats[1]+25) {
      screenNumber = 3;
    }
  }  
  if (screenNumber == 2) {

    if (mouseX >= them[0] && mouseX <= them[1] && mouseY >= them[2] && mouseY <= them[3]) {
      if (Theme.equals("Dark")) {
        Theme = "Light";
        newBG[0] = 255;
        newBG[1] = 255;
        newBG[2] = 255;
        newText[0] = 0;
        newText[1] = 0;
        newText[2] = 0;
        newPicCol = 0;
        if (cScheme.equals("Blue")) {
          newColors[0] = 50;
          newColors[1] = 130;
          newColors[2] = 184;
        } else if (cScheme.equals("Red")) {
          newColors[0] = 128;
          newColors[1] = 0;
          newColors[2] = 0;
        } else if (cScheme.equals("Green")) {
          newColors[0] = 98;
          newColors[1] = 153;
          newColors[2] = 107;
        } else if (cScheme.equals("Orange")) {
          newColors[0] = 252;
          newColors[1] = 134;
          newColors[2] = 33;
        } else if (cScheme.equals("Purple")) {
          newColors[0] = 117;
          newColors[1] = 121;
          newColors[2] = 231;
        } else if (cScheme.equals("Turquoise")) {
          newColors[0] = 0;
          newColors[1] = 136;
          newColors[2] = 145;
        }
        customTheme = false;
      } else if (Theme.equals("Light")) {
        Theme = "Really Dark";
        newText[0] = 255;
        newText[1] = 255;
        newText[2] = 255;
        newBG[0] = 0;
        newBG[1] = 0;
        newBG[2] = 0;
        newPicCol = 255;
        newColors[0] = 0;
        newColors[1] = 0;
        newColors[2] = 0;
      } else if (Theme.equals("Really Dark")) {
        Theme = "Really Light";
        newText[0] = 0;
        newText[1] = 0;
        newText[2] = 0;
        newBG[0] = 255;
        newBG[1] = 255;
        newBG[2] = 255;
        newPicCol = 0;
        newColors[0] = 255;
        newColors[1] = 255;
        newColors[2] = 255;
      } else if (Theme.equals("Really Light")) {
        Theme = "Custom";
        customTheme = true;
        loadCustomTheme(true);
      } else {
        Theme = "Dark";
        newBG[0] = 0;
        newBG[1] = 0;
        newBG[2] = 0;
        newText[0] = 255;
        newText[1] = 255;
        newText[2] = 255;
        newPicCol = 255;
        if (cScheme.equals("Blue")) {
          newColors[0] = 50;
          newColors[1] = 130;
          newColors[2] = 184;
        } else if (cScheme.equals("Red")) {
          newColors[0] = 128;
          newColors[1] = 0;
          newColors[2] = 0;
        } else if (cScheme.equals("Green")) {
          newColors[0] = 98;
          newColors[1] = 153;
          newColors[2] = 107;
        } else if (cScheme.equals("Orange")) {
          newColors[0] = 252;
          newColors[1] = 134;
          newColors[2] = 33;
        } else if (cScheme.equals("Purple")) {
          newColors[0] = 117;
          newColors[1] = 121;
          newColors[2] = 231;
        } else if (cScheme.equals("Turquoise")) {
          newColors[0] = 0;
          newColors[1] = 136;
          newColors[2] = 145;
        }
        customTheme = false;
      }
    } else if (mouseX >= clr[0] && mouseX <= clr[1] && mouseY >= clr[2] && mouseY <= clr[3]) {
      if (!customTheme && !Theme.equals("Really Dark") && !Theme.equals("Really Light")) {
        if (cScheme.equals("Blue")) {
          cScheme = "Red";
          newColors[0] = 128;
          newColors[1] = 0;
          newColors[2] = 0;
        } else if (cScheme.equals("Red")) {
          cScheme = "Green";
          newColors[0] = 98;
          newColors[1] = 153;
          newColors[2] = 107;
        } else if (cScheme.equals("Green")) {
          cScheme = "Orange";
          newColors[0] = 252;
          newColors[1] = 134;
          newColors[2] = 33;
        } else if (cScheme.equals("Orange")) {
          cScheme = "Purple";
          newColors[0] = 117;
          newColors[1] = 121;
          newColors[2] = 231;
        } else if (cScheme.equals("Purple")) {
          cScheme = "Turquoise";
          newColors[0] = 0;
          newColors[1] = 136;
          newColors[2] = 145;
        } else if (cScheme.equals("Turquoise")) {
          cScheme = "Blue";
          newColors[0] = 50;
          newColors[1] = 130;
          newColors[2] = 184;
        }
      }
    } else if (mouseX >= verboseButton[0] && mouseX <= verboseButton[1] && mouseY >= verboseButton[2] && mouseY <= verboseButton[3]) {
      if (TMSyncc.equals("On")) {
        booster.showConfirmDialog(
          "This action requires a restart of TMQM. Are you sure?", 
          "Confirm Reboot", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );
        if (isConfirmed) {
          TMSyncc = "Off";
          offlineMode = true;
          tmSyncc = false;
          updateFile();
          reset(false);
          setup();
        } else {
        }
      } else {
        booster.showConfirmDialog(
          "This action requires a restart of TMQM. Are you sure?", 
          "Confirm Reboot", 
          new Runnable() {
          public void run() {
            isConfirmed = true;
          }
        }
        , 
          new Runnable() {
          public void run() {
            isConfirmed = false;
          }
        }
        );
        if (isConfirmed) {
          TMSyncc = "On";
          offlineMode = false;
          tmSyncc = true;
          updateFile();
          reset(false);
          setup();
        } else {
        }
      }
    }
    updateFile();
  } else if (screenNumber == 3) {
    Theme = "Custom";
    customTheme = true;
    updateFile();
    if (mouseY >= 0 && mouseY <=height*0.102986612) {
      try {
        sideBar = booster.showColorPickerAndGetRGB("Choose the color scheme for the TMQM Sidebar", "SideBar Color picking");
        newColors[0] = (round(red(sideBar)));
        newColors [1] = (round(green(sideBar)));
        newColors [2] = (round(blue(sideBar)));
      }
      catch (Exception e) {
        booster.showWarningDialog("Invalid Entry", "Warning");
      }
    } else if (!(mouseX >= 0 && mouseX <= width*0.05859375)) {
      try {
        bg = booster.showColorPickerAndGetRGB("Choose the color for TMQM's background", "Background Color picking");
        newBG[0] = (round(red(bg)));
        newBG [1] = (round(green(bg)));
        newBG [2] = (round(blue(bg)));
      }
      catch (Exception e) {
        booster.showWarningDialog("Invalid Entry", "Warning");
      }
    }
    updateThemeFile();
  }
}

void colorShift(int r, int g, int b) {
  if (colors[0] > r) {
    colors[0]-=transSpeed;
  } else if (colors[0] < r) {
    colors[0]+=transSpeed;
  }
  if (colors[1] > g) {
    colors[1]-=transSpeed;
  } else if (colors[1] < g) {
    colors[1]+=transSpeed;
  }
  if (colors[2] > b) {
    colors[2]-=transSpeed;
  } else if (colors[2] < b) {
    colors[2]+=transSpeed;
  }
}

void colorShiftBG(int r, int g, int b) {
  if (backGroundColor[0] > r) {
    backGroundColor[0]-=transSpeed;
  } else if (backGroundColor[0] < r) {
    backGroundColor[0]+=transSpeed;
  }
  if (backGroundColor[1] > g) {
    backGroundColor[1]-=transSpeed;
  } else if (backGroundColor[1] < g) {
    backGroundColor[1]+=transSpeed;
  }
  if (backGroundColor[2] > b) {
    backGroundColor[2]-=transSpeed;
  } else if (backGroundColor[2] < b) {
    backGroundColor[2]+=transSpeed;
  }
}
void colorShiftText(int r, int g, int b) {
  if (textColor[0] > r) {
    textColor[0]-=transSpeed;
  } else if (textColor[0] < r) {
    textColor[0]+=transSpeed;
  }
  if (textColor[1] > g) {
    textColor[1]-=transSpeed;
  } else if (textColor[1] < g) {
    textColor[1]+=transSpeed;
  }
  if (textColor[2] > b) {
    textColor[2]-=transSpeed;
  } else if (textColor[2] < b) {
    textColor[2]+=transSpeed;
  }
}

void colorShiftImg(int r) {
  if (picCol > r) {
    picCol-=transSpeed;
  } else if (picCol < r) {
    picCol+=transSpeed;
  }
}
