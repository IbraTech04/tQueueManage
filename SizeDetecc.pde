void techMasterSizeDeteccV3() {
  float wid = width;
  float hei = height;
  //title
  posName[0] =  wid*0.5;
  posName[1] = hei*0.104166667;
  //Name Preview
  posView[0] = wid*0.5;
  posView[1] = hei*0.20;
  //Home Icon
  home[0] = wid*0.02734375;
  home[1] = hei*0.326388889;
  //Settings Icon
  settings[0] = wid*0.02734375;
  settings[1] = hei*0.417095778;
  //Stats Icon
  stats[0] = wid*0.02734375;
  stats[1] = hei*0.5078024668;
  //Theme Toggle Button Coords
  them[0] = wid*0.37109375;
  them[1] = wid*0.62734375;
  them[2] = hei*0.231944444;
  them[3] = hei*0.291666667;
  //Color Button Toggle Coords
  clr[0] = wid*0.30703125;
  clr[1] = wid*0.68203125;
  clr[2] = hei*0.305555556;
  clr[3] = hei*0.369444444;
  //Theme Text Position
  themPos[0] = hei*0.291666667;
  //Color Text Position
  clrPos[0] = hei*0.361111111;
  //Verbose Text Position  
  verbosePos[0] = hei*0.430555556;
  //UDP Socket text position
  UDPSPos[0] = hei*0.5;
  //UDP IP Text Position
  UDPIPPos[0] = hei*0.569444444;
  //Admin Commands Text Position
  adminCommandPos[0] = hei*0.638888889;
  //Verbose Button Coords
  verboseButton[0] = wid*0.27265625;
  verboseButton[1] = wid*0.71796875;
  verboseButton[2] = hei*0.376388889;
  verboseButton[3] = hei*0.427777778;
  /*
(mouseX >=349 && mouseX <= 919 && mouseY >= 271 && mouseY <=308  */
}

float[] posName = {1280, -450};
float[] posView = {1280, 350};
float[] settings = {0, 0}, home = {0, 0}, stats = {0, 0};
float[] them = {0, 0, 0, 0}, clr = {0, 0, 0, 0}, themPos = {0, 0}, clrPos = {0, 0}, verbosePos = {0, 0}, UDPSPos={0, 0}, UDPIPPos = {0, 0}, adminCommandPos = {0, 0};
float[] verboseButton = {0, 0, 0, 0};
