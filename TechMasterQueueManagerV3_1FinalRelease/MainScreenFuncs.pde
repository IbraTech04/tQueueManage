String a1=""; 


String GetTextFromClipboard () {
  String text = (String) GetFromClipboard(DataFlavor.stringFlavor);

  if (text==null) 
    return "";

  return text;
}

Object GetFromClipboard (DataFlavor flavor) {

  Clipboard clipboard = getJFrame(getSurface()).getToolkit().getSystemClipboard();

  Transferable contents = clipboard.getContents(null);
  Object object = null; // the potential result 

  if (contents != null && contents.isDataFlavorSupported(flavor)) {
    try
    {
      object = contents.getTransferData(flavor);
      println ("Clipboard.GetFromClipboard() >> Object transferred from clipboard.");
    }

    catch (UnsupportedFlavorException e1) // Unlikely but we must catch it
    {
      println("Clipboard.GetFromClipboard() >> Unsupported flavor: " + e1);
      e1.printStackTrace();
    }

    catch (java.io.IOException e2)
    {
      println("Clipboard.GetFromClipboard() >> Unavailable data: " + e2);
      e2.printStackTrace() ;
    }
  }

  return object;
} 

static final javax.swing.JFrame getJFrame(final PSurface surf) {
  return
    (javax.swing.JFrame)
    ((processing.awt.PSurfaceAWT.SmoothCanvas)
    surf.getNative()).getFrame();
}

void pasteToText(int state, String toPaste) {
  if (state == 0) {
    userName+=toPaste;
  } else if (state == 1) {
    pID += toPaste;
  } else if (state == 2) {
    pKey += toPaste;
  } else if (state == 4) {
    currentName += toPaste;
  }
}

void facReset() {
  preferences = createWriter("data/Preferences.tmqm");
  preferences.println("TMQM_SETTINGS");

  preferences.println("UDP_IP:224.0.1.1");

  preferences.println("THEME:DARK");

  preferences.println("VERBOSELOAD:FALSE");

  preferences.println("ADMIN_COMMAND:ENABLED");
  preferences.println("UDP_SOCKET:6000");
  preferences.println("COLOR_SCHEME:BLUE");
  preferences.println("TMSYNCC:ON");
  preferences.println("\nCHANGE UDP IP TO CHANGE WHICH CHANNEL THE UDP SERVER COMMUNICATES ON");
  preferences.println("CHNAGE UDP SOCKET ^^");
  preferences.println("VERBOSE LOAD TOGGLES THE VERBOSE LOADING EFFECT");
  preferences.println("ADMINCOMMAND ENABLES OR DISABLES ADMIN COMMANDS IN THE CLIENT");
  preferences.println("CHANGE THEME TO CUSTOM TO LOAD THE CUSTOM THEME. STANDARD THEMES INCLUDE DARK AND LIGHT AS OF RIGHT NOW");
  preferences.println("CHANGE COLOR SCHEME TO EITHER BLUE, RED, GREEN, OR GREY.");
  preferences.flush();
  preferences.close();
  licence = createWriter("data/ActivationInfo.tmqm");
  reset();
  setup();
}
