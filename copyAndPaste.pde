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
      e1.printStackTrace();
    }

    catch (java.io.IOException e2)
    {
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
    uName+=toPaste;
  } else if (state == 1) {
    pKey += toPaste;
  } else if (state == 4) {
    queue.currentName += toPaste;
  }
}
