int tet = 0;

void firstTimeSetup() {
  fadeIn(15, "1");
  background(0);
  screenNumber = 5;
  textFont(boldFont, 60);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2], alpha1);
  text("Welcome to TechMasterQueueManager V"+ver, width/2, height/2-250);
  textFont(font, 35);
  text("Providing Industry leading Queue Management", width/2, height/2-200);
  text("Before we continue, we need your licence information \n This information is most likely in your confirmation email", width/2, height/2-150);
  textFont(boldFont, 40);
  text("UserName: " + userName, width/2, height/2-50);
  text("Product ID: " + pID, width/2, height/2);
  text("Product Key: "+pKey, width/2, height/2+50);
  if (state == 3) {
    fadeOut(15, "main");
    licence.println("ProductInfo:");
    licence.println("ProductOwner:");
    licence.println(userName);
    licence.println("ProductKey:");
    licence.println(pID);
    licence.println("ProductID:");
    licence.println(pKey);
    licence.flush();
    state++;
    techMasterCracc(true);
    techMasterProtecc();
    startupState = 1;
  }
}

void fSetupDone() {
}
