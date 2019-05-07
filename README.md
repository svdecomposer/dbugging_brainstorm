# dbugging_matlab_projects
In order to debug a project it might become useful to set a breakpoint in every single file the project has (that is, every single .m file). However depending on the size and how the code is written, this might become tedious and impractical. This tools automates the process of (i) finding all .m files in a project. (ii) set a breakpoint at the begining of every single file (iii) disable all breakpoints. All with two easy to type commands.

Use it in combination with a configuration file (by default .dbProject). This way you can have several debugging profiles.

Note. Files inside class definition folders (which start with '@') won't be included in the debugging files.

# Description
The tool has only two functions. 'dbon'and 'dboff'.
The first one, 

```matlab
>>dbon 
```
Will search for .dbProject in your path. From that config file it will locate an input folder and will also read a number of files where NOT to set a breakpoint.`matlab

```matlab
>>dbon('file_config')
```
Will allow you to specify your own configuration file.

Config file must be a text file. Doesn't need to be .txt it can have any extension. In fact, by default it won't have extension, that way it will be easier to not be confused with the actual project.

First line starts with "::" followd by the address of the folder where one wants to set the entry point for the recursive file search.

To clear all breakpoint set.
```matlab
>>dboff
```
 It is just an alias for "dbclear all".

# Config file example
```text
::toolbox_folder
panel_realtime
macro_method
java_call
java_create
```

If no config file is found, the entry point will be the actual folder, and every .m file found will have a breakpoint.

Hope it is useful to your purposes. 
# Happy debugging!

