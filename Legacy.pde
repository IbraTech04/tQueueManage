void legacyLicence() {
  techMasterProtecc();
  techMasterCracc();
  if (active && active2) {
    booster.showInfoDialog("Congratulations on upgrading to TMQMV4. Your licence information has successfully been mingrated! \nWe hope you enjoy tQueueManageV4!tQueueManage");
    updateLicenceFile();
    activated = true;
    isSetup = true;
  }
}

void updateLicenceFile() {
  String[] Activated = loadStrings("ActivationInfo.tmqm");
  String newKey = Activated[6];
  newKey += "-"+addUp(Activated[2]);
  Licence = createWriter("data/ActivationInfo.tmqm");
  Licence.println("TMQMV4 Activation File (Do not modify this file unless you know what you're doing):");
  Licence.println("ProductOwner:");
  Licence.println(Activated[2]);
  Licence.println("ProductKey:");
  Licence.println(newKey);
  Licence.flush();
}

void techMasterProtecc() {
  String date = "";
  String year = "";
  int div7 = 0;
  int div5 = 0;
  String[] Activated = loadStrings("ActivationInfo.tmqm");
  if (Activated.length != 0) {
    String workWith = Activated[6];
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
                active2 = true;
              }
            }
          }
        }
      }
    }
  }
}
void techMasterCracc() {
  String proKey = "";
  String[] pcHash = loadStrings("ActivationInfo.tmqm");
  String docProKey = pcHash[4];
  String current = pcHash[2];
  for (int A = 0; A < current.length(); A++) {
    char temp = current.charAt(A);
    if (temp == 'A') {
      proKey += 1;
    } else if (temp == 'B') {
      proKey += 2;
    } else if (temp == 'C') {
      proKey += 3;
    } else if (temp == 'D') {
      proKey += 4;
    } else if (temp == 'E') {
      proKey += 5;
    } else if (temp == 'F') {
      proKey += 6;
    } else if (temp == 'G') {
      proKey += 7;
    } else if (temp == 'H') {
      proKey += 8;
    } else if (temp == 'I') {
      proKey += 9;
    } else if (temp == 'J') {
      proKey += 10;
    } else if (temp == 'K') {
      proKey += 11;
    } else if (temp == 'L') {
      proKey += 12;
    } else if (temp == 'M') {
      proKey += 13;
    } else if (temp == 'N') {
      proKey += 14;
    } else if (temp == 'O') {
      proKey += 15;
    } else if (temp == 'P') {
      proKey += 16;
    } else if (temp == 'Q') {
      proKey += 17;
    } else if (temp == 'R') {
      proKey += 18;
    } else if (temp == 'S') {
      proKey += 19;
    } else if (temp == 'T') {
      proKey += 20;
    } else if (temp == 'U') {
      proKey += 21;
    } else if (temp == 'V') {
      proKey += 22;
    } else if (temp == 'W') {
      proKey += 23;
    } else if (temp == 'X') {
      proKey += 24;
    } else if (temp == 'Y') {
      proKey += 25;
    } else if (temp == 'Z') {
      proKey += 26;
    }
  }
  if (docProKey.equals(proKey)) {
    active = true;
  }
}
