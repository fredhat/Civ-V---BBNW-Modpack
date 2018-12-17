# Civ V Beyond Brave New World Modpack

A collection of new and existing mods for Civ V that have been heavily edited for stability when packed into a multiplayer modpack.

## Duplicating My Test Environment

Clone this repository to your Civ V MODS directory in /My Documents/My Games/Sid Meier's Civilization 5/. Make sure your MODS directory is empty beforehand.

### Prerequisites

This modpack relies on a heavily modified build of EUI to avoid graphical irregularities. You can acquire it at the following link:

```
https://www.dropbox.com/s/eveol3828nctop4/Civ%20V%20Setup.zip?dl=0
```

### Setting Up EUI & Loading the Modpack

Extract the downloaded BBNW_EUI.zip.

Place UI_bc1 into your Civ V DLC folder. This folder can usually be found at:

```
C:/Program Files (x86)/Steam/steamapps/common/Sid Meyer's Civilization V/Assets/DLC/
```

Place EUI_text_en_us.xml into your Civ V Text folder. This folder can usually be found at:

```
C:/Users/{Username}/Documents/My Games/Sid Meier's Civilization 5/Text/
```

Now you should be ready to launch Civ V and enable the modpack:

```
After Civ V is finished loading, you'll probably want to edit your EUI settings under 'OPTIONS'.
After that, you can head into 'MODS' and begin enabling the mods one at a time, enabling 'DLL - Various Mod Components (v 88)' first.
Make sure to skip enabling 'Multiplayer Mods Workaround (v 1)'. It should only be enabled when building the modpack.
Once all the other mods are enabled, you can press 'NEXT' and wait for the modpack to load.
You should now be ready to test Civ V Beyond Brave New World.
```

### Building the Modpack

You will need to do some prepwork before launching Civ V and loading your modpack:

```
Go to /MODS/DLL - Various Mod Components (v 88)/DLL/ and move 'CvGameCore_Expansion2.dll' to somewhere safe.
Launch Firetuner, it will be necessary to build the modpack.
Launch Civ V, go to 'MODS' and enable 'Multiplayer Mods Workaround (v 1)'.
Press 'NEXT' and wait for the modpack to load. 
```

If you experience no crashes, you can now build the modpack.

```
Once loaded, start the game as a simple vanilla civilization like Morocco or Arabia.
Go into Firetuner and click the 'Connection' tab followed by the 'Change Connection' option.
Once Firetuner finishes reconnecting, go to the dropdown in Firetuner's main Lua Console.
Scroll up until you see a filepath and click on it.
In the text box at the bottom of Firetuner's main Lua Console type CreateMP() and hit ENTER.
Your game will freeze and your modpack will start building.
Once you see 'Done!' in the Firetuner's main Lua Console message box you can close Firetuner followed by Civ V.
Go to where you moved 'CvGameCore_Expansion2.dll' and create a copy.
Move that copy into C:/Program Files (x86)/Steam/steamapps/common/Sid Meyer's Civilization V/Assets/DLC/MP_MODSPACK/Mods/DLL - Various Mod Components (v 88)/DLL/.
You should now be ready to play your modpack in multiplayer and without having to load any mods.
```

In case you want to reset your build environment afterwards:

```
Return the original 'CvGameCore_Expansion2.dll' to /MODS/DLL - Various Mod Components (v 88)/DLL/.
Go to C:/Program Files (x86)/Steam/steamapps/common/Sid Meyer's Civilization V/Assets/DLC/ and delete MP_MODSPACK.
Launch Civ V, go to 'MODS' and disable 'Multiplayer Mods Workaround (v 1)'.
Press 'NEXT' and wait for the modpack to load. 
```

## For Those Looking for Just the Finished Modpack Build

You can find the most recent build at the following link:

```
https://www.dropbox.com/s/eveol3828nctop4/Civ%20V%20Setup.zip?dl=0
```

Make sure to follow the Readmes carefully if you want the most stable multiplayer experience.
