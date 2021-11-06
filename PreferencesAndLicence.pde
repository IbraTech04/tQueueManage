void ultraProtecc() { //<>//
  String date = "";
  String year = "";
  int div7 = 0;
  int div5 = 0;
  String[] Activated = loadStrings("ActivationInfo.tmqm");
  if (Activated.length != 0 && Activated[0].contains("V4")) {
    isSetup = true; 
    String workWith = Activated[4];
    pKey = workWith;
    String[] splitWW = split(workWith, "-");
    if (splitWW.length > 1) {

      if (splitWW[1].equals("OEM")) {
        for (int A = 0; A < 3; A++) {
          String toAdd = str(splitWW[0].charAt(A));
          date += toAdd;
        }
        int test = int(date);
        if (test != 000) {
          for (int A = 3; A < 5; A++) {
            String toAdd = str(splitWW[0].charAt(A));
            year += toAdd;
          }
          int iyear = int(year);
          if (iyear >= 20) {
            for (int A = 0; A < 7; A++) {
              String toAdd = str(splitWW[2].charAt(A));
              int toAddto = int(toAdd);
              div7 = div7 + toAddto;
            }
            if (isDiv7(div7)) {
              for (int A = 0; A < 5; A++) {
                String toAdd = str(splitWW[3].charAt(A));
                int toAddto = int(toAdd);
                div5 += toAddto;
              }
              if (isDiv5(div5)) {
                if (splitWW[4].equals(str(addUp(Activated[2])))) {
                  activated = true;
                  uName = Activated[2];
                }
              }
            }
          }
        }
      }
    }
  } else {
    if (Activated.length != 0 && Activated[0].equals("ProductInfo:")) {
      legacyLicence();
    } else {
      isSetup = false;
    }
  }
}
int addUp(String current) {
  int proKey = 0;
  licenceOwner = current;
  for (int A = 0; A < current.length(); A++) {
    char temp = current.charAt(A);
    proKey+= int(temp);
  }
  return proKey;
}


boolean isOdd(int n) {
  return n % 2 != 0;
}

boolean isDiv7(int n) {
  return n % 7 == 0;
}

boolean isDiv5(int n) {
  return n % 5 == 0;
}

void loadPreferences() {
  pref = loadStrings("Preferences.tmqm");
  UDPIP = split(pref[1], ':')[1];
  UDPPort = int(split(pref[2], ':')[1]);
  TMSyncc = split(pref[3], ':')[1]; 
  if (TMSyncc.equals("On")) {
    tmSyncc = true;
    offlineMode = false;
  } else {
    tmSyncc = false;
    offlineMode = true;
  }
  Theme = split(pref[4], ':')[1];
  cScheme = split(pref[5], ':')[1];
  if (Theme.equals("Dark")) {
    backGroundColor[0] = 0;
    backGroundColor[1] = 0;
    backGroundColor[2] = 0;
    textColor[0] = 255;
    textColor[1] = 255;
    textColor[2] = 255;
    newBG[0] = 0;
    newBG[1] = 0;
    newBG[2] = 0;
    newText[0] = 255;
    newText[1] = 255;
    newText[2] = 255;
    newPicCol = 255;
  } else if (Theme.equals("Light")) {
    newPicCol = 0;
    backGroundColor[0] = 255;
    backGroundColor[1] = 255;
    backGroundColor[2] = 255;
    textColor[0] = 0;
    textColor[1] = 0;
    textColor[2] = 0;
    newBG[0] = 255;
    newBG[1] = 255;
    newBG[2] = 255;
    newText[0] = 0;
    newText[1] = 0;
    newText[2] = 0;
  } else if (Theme.equals("Really Dark")) {
    newText[0] = 255;
    newText[1] = 255;
    newText[2] = 255;
    textColor[0] = 255;
    textColor[1] = 255;
    textColor[2] = 255;
    backGroundColor[0] = 0;
    backGroundColor[1] = 0;
    backGroundColor[2] = 0;
    newBG[0] = 0;
    newBG[1] = 0;
    newBG[2] = 0;
    newPicCol = 255;
    colors[0] = 0;
    colors[1] = 0;
    colors[2] = 0;
    newColors[0] = 0;
    newColors[1] = 0;
    newColors[2] = 0;
  } else if (Theme.equals("Really Light")) {
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
    colors[0] = 255;
    colors[1] = 255;
    colors[2] = 255;
    textColor[0] = 0;
    textColor[1] = 0;
    textColor[2] = 0;
    backGroundColor[0] = 255;
    backGroundColor[1] = 255;
    backGroundColor[2] = 255;
  } else if (Theme.equals("Custom")) {
    loadCustomTheme(false);
    customTheme = true;
  }
  if (!customTheme && !Theme.equals("Really Dark") && !Theme.equals("Really Light")) {
    if (cScheme.equals("Blue")) {
      colors[0] = 50;
      colors[1] = 130;
      colors[2] = 184;
      newColors[0] = 50;
      newColors[1] = 130;
      newColors[2] = 184;
    } else if (cScheme.equals("Red")) {
      colors[0] = 128;
      colors[1] = 0;
      colors[2] = 0;
      newColors[0] = 128;
      newColors[1] = 0;
      newColors[2] = 0;
    } else if (cScheme.equals("Green")) {
      colors[0] = 92;
      colors[1] = 153;
      colors[2] = 107;
      newColors[0] = 92;
      newColors[1] = 153;
      newColors[2] = 107;
    } else if (cScheme.equals("Orange")) {
      newColors[0] = 252;
      newColors[1] = 134;
      newColors[2] = 33;
      colors[0] = 252;
      colors[1] = 134;
      colors[2] = 33;
    } else if (cScheme.equals("Purple")) {
      newColors[0] = 117;
      newColors[1] = 121;
      newColors[2] = 231;
      colors[0] = 117;
      colors[1] = 121;
      colors[2] = 231;
    } else if (cScheme.equals("Turquoise")) {
      newColors[0] = 0;
      newColors[1] = 136;
      newColors[2] = 145;
      colors[0] = 0;
      colors[1] = 136;
      colors[2] = 145;
    }
  }
}
void updateFile() {
  Pref = createWriter("data/Preferences.tmqm");
  Pref.println("TMQM_Settings");
  Pref.println("UDP IP:" + UDPIP);
  Pref.println("UDP Socket:" + UDPPort);
  Pref.println("TMShare:" + TMSyncc);
  Pref.println("Theme:" + Theme);
  Pref.println("Color Scheme:" + cScheme);
  Pref.flush();
}
void loadCustomTheme(boolean booted) {
  String[] theme = loadStrings("customTheme.tmqm");
  String[] temp = split(theme[1], ":");
  int[] tempBG = int(split(temp[1], ","));
  newBG[0] = tempBG[0];
  newBG[1] = tempBG[1];
  newBG[2] = tempBG[2];
  String[] tempText = split(theme[2], ":");
  int[] temptext = int(split(tempText[1], ","));
  newText[0] = temptext[0];
  newText[1] = temptext[1];
  newText[2] = temptext[2];
  String[] coloro = split(theme[3], ":");
  int[] tempcolor = int(split(coloro[1], ","));
  newColors[0] = tempcolor[0];
  newColors[1] = tempcolor[1];
  newColors[2] = tempcolor[2];
  String[] iconColor = split(theme[4], ":");
  if (iconColor[1].equals("White")) {
    newPicCol = 255;
  } else {
    newPicCol = 0;
  }
  if (!booted) {
    picCol = newPicCol; 
    colors[0] = tempcolor[0];
    colors[1] = tempcolor[1];
    colors[2] = tempcolor[2];
    textColor[0] = temptext[0];
    textColor[1] = temptext[1];
    textColor[2] = temptext[2];
    backGroundColor[0] = tempBG[0];
    backGroundColor[1] = tempBG[1];
    backGroundColor[2] = tempBG[2];
  }
}

void updateThemeFile() {
  cTheme = createWriter("data/customTheme.tmqm");
  cTheme.println("TMQM CUSTOM THEME FILE");
  cTheme.println("Background Color:" + newBG[0] + "," + newBG[1] + "," + newBG[2]);
  cTheme.println("Text Color:" + newText[0] + "," + newText[1] + "," + newText[2]);
  cTheme.println("Color Scheme:" + newColors[0] + "," + newColors[1] + "," + newColors[2]);
  if (newPicCol == 255) {
    cTheme.println("Icon Color:White");
  } else {
    cTheme.println("Icon Color:Black");
  }
  cTheme.flush();
  cTheme.close();
}

void corruptLicence() {
  writeLicence(true);
  reset(false);
  setup();
}


void writeLicence(boolean disabled) {
  Licence = createWriter("data/ActivationInfo.tmqm");
  Licence.println("TMQM V4 Activation File (Do not modify this file unless you know what you're doing):");
  Licence.println("ProductOwner:");
  Licence.println(uName);
  Licence.println("ProductKey:");
  Licence.println(pKey);
  if (disabled) {
    Licence.println("DISABLED:TRUE");
  } else {
    Licence.println("DISABLED:FALSE");
  }
  Licence.flush();
}
