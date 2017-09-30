% Author:         Joe Zhang
% Email:          zhaoz@princeton.edu
% Date Started:   04/08/17
% Date Updated:   05/04/17
%
% Function: scanDensityCalc
%
% Input:  txtfile - scanDensity.txt
% Output: n/a
%
% Description: Reads in 'scanDensity.txt' and determines the mean
%              calculated scan density with variance and standard
%              deviation.  Prints results to 'scanDensityCalc.txt'
%
% BEGIN CODE
function scanDensityCalc(txtfile)

% reads in the file and creates a matrix with all fields
fileID=fopen(txtfile,'r');
format='%*s %f %f %d';
sizeA=[3,Inf];
A=fscanf(fileID,format,sizeA);
fclose(fileID);
A=A';
scans=A(:,1); errors=A(:,2); numTraces=A(:,3);

% Computes the mean with variance and standard deviation
mean=sum(scans)/length(scans);
error=sum(errors)/length(errors);
variance=var(scans);
stddev=std(scans);

% Prints results with description to 'scanDensityResults.txt'
fid=fopen('/Users/zhaozhang/frs124/GPR/code/scanDensityResults.txt','a+');
sGPR='GPR default setting:          50\n';
smean='Calculated mean scan density: %.2f\n';
serr='Error:                        %.2f\n';
svar='Variance:                     %.2f\n';
sstd='Standard Deviation:           %.2f\n';
fprintf(fid,strcat(sGPR,smean,serr,svar,sstd),mean,error,variance,stddev);
fclose(fid);
end