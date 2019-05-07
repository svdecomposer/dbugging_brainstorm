% alias script 'dboff' as 'dbclear all' to debug a matlab project.
%
% Syntax: alias script
%         This script is just an alias for dbclear all. It clears all the
%         breaking points enabled in matlab.
%   
% Inputs: 
%    [No inputs]
%
% Outputs:
%    [No outputs]
%
% Example: 
%    >> dboff  
%
% Other m-files required: dbModeOn
%
% Author: Juan Garcia-Prieto
% Project: https://github.com/svdecomposer/dbugging_matlab_projects
% email: juangpc@gmail.com
% May 2019; 
%------------- BEGIN CODE --------------
dbclear all
