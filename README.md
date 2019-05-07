# dbugging_matlab_projects
A tool to set a breakpoint in every file in a set of folders and subfolders.

Use it in combination with a configuration file (by default .dbProject

#Description
The tool has only two functions. Hope it is useful to your purposes. 

```matlab
>>dbon 
```
Will search for .dbProject in your path. From that config file it will locate an input folder and will also read a number of files where NOT to set a breakpoint.`matlab

```matlab
>>dbon('file_config')
```
Will allow you to specify your own configuration file.

Config file must be a text file.

First line starts with "::" followd by the address of the folder where one wants to set the 

```matlab
>>dboff
```
Will clear all breakpoints. It is an alias for "dbclear all".

#Config file example
```text
::toolbox
panel_realtime
macro_method
java_call
java_create
```


#HappyHappy debugging!

