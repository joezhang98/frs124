% Author:       Joe Zhang
% Email:        zhaoz@princeton.edu
% Date Started: 03/30/17
% Date Updated: 04/04/17
%
% Function: [x,y,z]=gatherVariables(fname)
% 
% Input:  fname - csv file containing GPS points for a given transect line
% Output: x     - easting coordinates for each GPS point
%         y     - northing coordinates for each GPS point
%         z     - elevation measurement for each GPS point
%
% Description: The function gatherVariables collects easting, northing,
%              and elevation data from each csv file into the variables
%              x, y, and z, respectively, to make plotting more efficient
%
% BEGIN CODE
function [x,y,z]=gatherVariables(fname)

% Loads in the csv file for a certain line
lineData=csvread(fname);

% Assigns variables x, y, and z, to easting, northing, and elevation, resp.
x=lineData(:,6);
y=lineData(:,5);
z=lineData(:,1);
end