function dbon(configFile)
% dbon - A funtion to set parameters for freezing the execution of a Matlab
%        based project. It sets a break point at the begining of every .m
%        file in the folder (recursively) inside entryPointFolder.
%        It helps therefore, debug and understand the execution flow.
%
% Syntax:  dbon(configFile)
%
% Description: The script declares a variable files_not_to_stop which is a
%         cell array with names of .m files in a matlab project where one
%         does not want to set a break point for debuggin porpusese. Typically
%         you want to freeze all functions of a project except the ones
%         that are self explanatory or you have already studied.
%
%         Typically use with an alias script. An example is shown with
%         dbon and dboff scripts. Easy to remember and to type.
%
%
% Inputs: Name of the the configuration file.
%           [DEFAULT NAME] : '.dbProject'
%
%          The structure of the configuration file is as follows.
%
%          ::entryPointFolder
%          The first line of the txt file should start with '::' and
%          followed by the name of the folder to server as entry point
%          folder where the search for .m files starts.
%          This program searches (recursively) for .m files and sets a
%          breakpoint at the first line of each file.
%
%          listOfFilesToAvoid
%          Following the first line, each new line will contain the
%          name of a .m file to exclude from the debugging process.
%          Typically, some files in a project don't necesarily
%          add information. It can be because you already know what
%          they do, or because they are self-explanatory, or irrelevant.
%          Either way you don't want the execution to stop at that files.

%          Comments are indicated with a '::' symbol after which every
%          character will be discarded.
%
%          ::fin
%          The '::fin' string indicates the last part of the document which
%          will be read by the parser. You can write comments or previous
%          working lists there on, it won't affect the actual working list
%          of files.
%
% Outputs:
%    [No outputs]
%
% Example:
%    >> dbon('.dbProject')
%
% Author: Juan Garcia-Prieto
% Project: https://github.com/svdecomposer/dbugging_matlab_projects
% email: juangpc@gmail.com
% May 2019;
%------------- BEGIN CODE --------------

if ~exist('configFile','var')
  configFile='.dbProject';
end

[entryPointFolder,avoidList]=parseConfigFile(configFile);

fileStopList=searchForFiles(fullfile(pwd,entryPointFolder));

for fi=1:length(fileStopList)
  [~,name,~] = fileparts(fileStopList{fi});
  if ~any(strcmp(name,avoidList))
    eval(['dbstop in ' fileStopList{fi}]);
  end
end

end


%% Function parseConfigFile
% This function parses the folder name and the list of files to exclude. All
% should be specified in the config file.
function [entryPointFolder,avoidList]=parseConfigFile(configFile)
comment_str='::';
end_str='::fin';
fid=fopen(configFile);
if fid == -1
  entryPointFolder = pwd;
  avoidList = {};
else
  nline=fgetl(fid);
  if strcmp(nline(1:2),comment_str)
    entryPointFolder=strtrim(nline(3:end));
  else
    error(['Bad structure of configuration file: ' configFile]);
  end
  avoidList={};
  while ~feof(fid)
    nline=fgetl(fid);
    if ~isempty(nline)
      if length(nline)>4 && strcmp(nline(1:5),end_str)
        break
      end
      f_=split(nline,comment_str);
      fi=strtrim(f_{1});
      if isempty(fi)
        continue
      end
      avoidList=cat(2,avoidList,{fi}); %%trim spaces begining or ending
    end
  end
  fclose(fid);
end
end

%% Function searchForfiles
% This function is an (inefficient) implementation of recursive breath first
% search for .m files inside a folder.
% Inputs:
%    entryPointFolder : folder where the search for .m files starts. It
%                       searches (recursively) for .m files and sets a
%                       breakpoint in each file, at the initial line.
%
%    listOfFilesToAvoid : name of a txt file where each line contains the
%               name of a .m file to exclude from the debugging process.
%               Typically,some files in a project don't necesarily
%               add information. It can be because you already know what
%               they do, or because they are self-explanatory, or irrelevant.
%               Either way you don't want the execution to stop at that files.
%
% Outputs:
%    flist : The list of files found in all folders.
%
function flist=searchForFiles(thisFolder,flist)

if ~exist('flist','var')
  flist=[];
end

fl=dir(thisFolder);
fl=fl(3:end);

for fi=1:length(fl)
  if fl(fi).isdir
    if(fl(fi).name(1) == '.')
      continue;
    end
    if (fl(fi).name(1) ~= '@')
      flist=searchForFiles(fullfile(thisFolder,fl(fi).name),flist);
    end
  elseif strcmp(fl(fi).name(end-1:end),'.m')
    flist=cat(1,flist,{fullfile(thisFolder,fl(fi).name)});
  end
end

end
