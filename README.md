# TechMasterQueueManager

<p>TechMaster Queue Manager was a joke program created in a tech class. Since then, it has eveolved and become a full fledged queue manager, with UDP server functionality, sync functionality, a custom theme engine, and much more!
  
 <h2> Install Guide</h2>
 <p>This program was created in the Processing IDE, meaning you will need to download that in order to get it to work.
  
  You will also need a few libraries. To install them, go to Sketch > Import Library > Add Library. From there, search for "UI Booster", "UDP", "Sound", and "Video". Select each one and press install. Once the libraries are done installing, you're ready to compile and launch TMQM!</p>
  
  
  <h2>Features
  <h3>TMShare and TMSyncc</h3>
  <p>TMQM was designed to be an alternative to many popular queue management systems. The main feature is TMShare (UDP Server). This allows you to display the same queue across multiple screens. Along with this, TMQM has full support for TMSyncc, a companion app which aids in queue syncing. It's main goal is to ensure that all the queue data is the same across all TMQM clients, and that any new TMQM clients will be up-to-date. By launching a TMQM and TMSyncc client on the same network, UDP port and IP, they will automatically connect with each other, and TMSyncc will take over syncing the queue</p>
    <h3>TMRemote Admin</h3>
    <p>Along with syncing functionality, the TMSyncc companion app also serves as the adminstrator console. The administrator console has amny features:</p>
      <ul>
        <li>Admin.Remove.X</li>
        <ul>
          <li>Removes entry at location X (Array location. Example: 0)</li>
        </ul>
                <li>Admin.Modify.X.String</li>
        <ul>
          <li>Modify's the entry at location X with String</li>
        </ul>
                        <li>Admin.Swap.X.Y</li>
        <ul>
          <li>Swaps the entry at location X with the one at location Y</li>
        </ul>
                        <li>Admin.AddAt.X.String</li>
        <ul>
          <li>Adds String entry to the queue at point X</li>
        </ul>
                        <li>Admin.Clear</li>
        <ul>
          <li>Clears the queue</li>
        </ul>
                                                  <li>Admin.Add.String</li>
        <ul>
          <li>Adds String to the end of the queue</li>
        </ul>
    </ol>
     <h3>Built in Admin mode</h3>
       <p>TMQM has a built in admin mode for your convenience. By pressing `, the admin mode is activated (symbolized by the text "Admin Mode Active" in the bottom left). This mode is fairly primitive, however with it on you can use the up arrow to remove an entry in the queue, and by typing CLS and pressing enter, the queue is cleared. This feature can be disabled in Preferences.tmqm</p>
         <h3>GUI settings
           <p>By pressing the gear in the TMQMs sidebar, you can enter the GUI settings menu. From here, you can change the theme, color scheme, and TMSyncc/TMShare state
             <h3>Offline mode</h3>
               <p>TMQM can also be used in offline mode, which does not require an internet connection. By switching TMSyncc to off in the GUI settings menu, TMQM will function entirely off the network. This does also disable TMRemote Admin. TMQM can also auto-detect when TMSyncc is not functioning properly, and will alert the user and disable TMSyncc to prevent data loss</p>
                 <h3>Custom theme engine</h3>
                   <p>By changing the theme to CUSTOM in TMQM GUI settings, you can open customtheme.tmqm and entirely customize the UI to your liking. The document takes RGB color codes for all the elements of TMQM</p>
                     <h3>TMSizeDeteccV4</h3>
                       <p>TMQM is equipped with the brand new TMSizeDeteccV4, allowing it to be scaled and run in virtually any resoloution (over 1280x720/720p).</p>
                      
