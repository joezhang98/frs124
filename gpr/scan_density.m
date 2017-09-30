% Author:         Joe Zhang
% Email:          zhaoz@princeton.edu
% Date Started:   03/23/17
% Date Updated:   05/04/17
%
% Function: scanDensity
%
% Input:  fname     - name of the csv file that is read
%         numTraces - number of traces in the corresponding DZT file
% Output: n/a
%
% Description: Determines the scan density of the GPR by dividing the total
%              distance traveled for a scan by the number of traces taken.
%              This number is calculated for each line transect, along with
%              associated error, and output to 'scanDensity.txt'
%
% BEGIN CODE
function scanDensity(fname,numTraces)

% Loads in the CSV file for a certain line
lineData=csvread(fname);
elevation=lineData(:,1);
vertPrecision=lineData(:,2);
horzPrecision=lineData(:,3);
northing=lineData(:,5);
easting=lineData(:,6);

% Read (and report the number of points)
numPoints=length(elevation);

% Calculates the distance traveled by the GPR in the scan
elevStart=elevation(1); elevEnd=elevation(numPoints);
northStart=northing(1); northEnd=northing(numPoints);
eastStart=easting(1); eastEnd=easting(numPoints);
vertDistance2=(elevEnd-elevStart)^2;
horzDistance2=(northEnd-northStart)^2+(eastEnd-eastStart)^2;
distance=sqrt(horzDistance2+vertDistance2);

% Calculates the error in the distance
vertPercError=abs(2*((vertPrecision(1)+...
    vertPrecision(numPoints))/(elevEnd-elevStart)));
horzPercError=abs(2*((horzPrecision(1)+...
    horzPrecision(numPoints))/sqrt(horzDistance2)));
distPercError=0.5*(((vertPercError*vertDistance2)+...
    (horzPercError*horzDistance2))/(horzDistance2+vertDistance2));

% Determines the scan density from the DZT file and the associated error
scanCalc=numTraces/distance;
scanError=distPercError*scanCalc;

% Open a file and write some text to it
fid=fopen('/Users/zhaozhang/frs124/GPR/code/scanDensity.txt','a+');
fprintf(fid,'%s %f %f %i\n',fname,scanCalc,scanError,numTraces);
fclose(fid);
end
