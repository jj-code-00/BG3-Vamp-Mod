This is a mod template for class mods. Should get you started in whatever class you want to make.

Make Sure you have the tools necessary, namely:

1. LSLib by Norbyte (Export Tool). this let you pak and unpak files, convert file types, and a lot of powerful functions 
	(https://github.com/Norbyte/lslib)
2. Modder's Multitool. this will take a bit to set up, follow its instructions. This program allows you to search through game files to see if there is anything that you might be able to reuse or copy. 
	(https://github.com/ShinyHobo/BG3-Modders-Multitool)

Some other tools that you might want to use

1. Icons Generation: A modle uses stable diffusion to generate Icons with given prompt (keep it short). (https://www.nexusmods.com/baldursgate3/mods/521)
2. Image editing Software: Im cheap so im not going to pay for photoshop. GIMP gives me everything i need anyways (https://www.gimp.org)
3. Some sort of text editing software that is not the base Notepad. I have been using Notepad++ and its pretty good imo (https://notepad-plus-plus.org)
4. Larian's Official Discord Server. If you have any questions, a lot of people there are happy to help.

Some useful things I do for organization

1. a workspace decicated to modding with all of the tools in there
2. a folder inside the workspace dedicated to all extracted mods or WIP mods. I find it useful to take a look at other's mods to see how they might have implemented a feature to get inspiration, or just to see whats possible.
3. a shortcut to AppData\Local\Larian Studios\Baldur's Gate 3\Mods. You will be navigating between those your Workspace and the Mods folder very frequently espeically when trying to fix an annoying bug.

=================================================================================================================================================

Folder organization

*This structure does not include scripts or mod fixer*

Mod Folder
	- Localization
		- Language (English in this case)
			- .loca file (for game)
			- .xml file (for edits)
	- Mods
		- a folder with your mod (class) name (capitalization matters)
			- meta.lsx
	- Public
		- a folder with your mod (class) name (capitalization matters)
			- ActionResourceDefinitions
				- ActionResourceDefinitions.lsx (if your class uses a unique resource this is where you make it
			- Assets
				- Textures
					- Icons
						- .DDS File (a collection of your Icons)
			- CharacterCreationPresets
				- AbilityDistributionPresets.lsx (not necessary)
			- ClassDescriptions
				- ClassDescriptions.lsx (Where you will define your class and have it show up in Character creation, tho this file alone will crash your game when selecting it in CC)
			- Content
				- UI
					- [PAK]_UI
						- _merged.lsx <--- for editing
						- _merged.lsf <--- load the .DDS file from Assets\Textures\Icons\Example.DDS into the game
			- GUI
				- Icons_Example.lsx <-- this file splices up the .DDS file that was loaded into chunks, so you can fit a lot more Icons into the same sheet.
			- Lists
				- PassiveLists.lsx <-- lists of passives your class might want to choose from (like Warlock's invocations, or Magus' Arcanas)
				- SkillLists.lsx <-- list of skills to choose at Character creation, or other times if say, your class have expertise or something
				- SpellLists.lsx <-- lists of spells. Not necessarily magic spells, things like Weapon attacks are also considered "spells" in BG3
			- Progressions
				- Progressions.lsx <-- Where you define the specifc levels of your class and what do they get. To get a class working, the minimum you will need is this file and the ClassDescriptions.lsx file
			- Stats
				- Generated
					- Data (The file name inside this folder is not important)
						- Interrupt.txt <-- anything that you want a popup window involved (mostly reactions)
						- Passive.txt <-- where you would define passives
						- Spell.txt <-- where you would define your spells
						- Status_BOOSTS.txt <-- where you would define status effects
					- Equipment.txt <-- starting gear
					
=================================================================================================================================================

Other:

1. ValueList and Modifiers are two amazing files you can find through the Multitool to let you know what can be done with entries.

=================================================================================================================================================

Happy Modding!