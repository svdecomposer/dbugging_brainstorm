function dbModeOn(inputFolder,exceptionNames)
%dbModeOn - A tool to set a breakpoint in every file in a set of folders.
%
% Syntax:  function_name(inputFolder,exceptionNames)
%
% Inputs:
%    inputFolder - folder entry point.
%    exceptionNames - Cell array with names of files (without extension) 
%                     you don't want the tool to set breakpoints in.
%
% Outputs:
%    fileList - a list of files found.
%
% Example: 
%    dbModeOn(project_root_folder,{'parallel_stuff','java_stuff'});
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Juan Garcia-Prieto
% email: juangpc@gmail.com
% May 2019; 
%------------- BEGIN CODE --------------
fileList=[];
currentFolder=pwd;
fileList=searchForFiles(fileList,inputFolder);

for fi=1:length(fileList)
  [~,name,ext] = fileparts(fileList{fi});
  if strcmp(ext,'.m') && ...
    ~any(strcmp(name,exceptionNames))
    eval(['dbstop in ' fullfile(currentFolder,fileList{fi})]);
  end

end

end

function flist=searchForFiles(flist,thisFolder)
  fl=dir(thisFolder);
  fl=fl(3:end);
for fi=1:length(fl)
  if fl(fi).isdir
    if(fl(fi).name(1) == '.')
      continue;
    end
    if (fl(fi).name(1) ~= '@')
      flist=searchForFiles(flist,fullfile(thisFolder,fl(fi).name));
    end
  elseif strcmp(fl(fi).name(end-1:end),'.m')
    flist=cat(1,flist,{fullfile(thisFolder,fl(fi).name)});
  end
end
  
end

%------------- GOOD LUCK DEBUGGING!!! --------------
