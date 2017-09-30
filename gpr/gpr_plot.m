% Author:       Joe Zhang
% Email:        zhaoz@princeton.edu
% Date Started: 03/30/17
% Date Updated: 04/04/17
%
% Description: Prints interpreted GPR images to .pdf format for TPR03
%
% BEGIN CODE
file32=imread('FILE____032.png');
imshow(file32)
h=xlabel('Distance from Starting Point [m]','FontSize',24);
pos = get(h,'pos'); % Read position [x y z]
set(h,'pos',pos+[0 -40 0]) % Move label to right
j=ylabel('Depth from Surface [m]','FontSize',24);
posy=get(j,'pos');
set(j,'pos',posy+[40 0 0])
figdir='/Users/zhaozhang/frs124/GPR/submissions';
% Issue the print command, which does the same as "save" it
print('-dpdf','-bestfit',fullfile(figdir,'gpr02-fig.pdf'))

file36=imread('FILE____036.png');
imshow(file36)
h=xlabel('Distance from Starting Point [m]','FontSize',24);
pos = get(h,'pos'); % Read position [x y z]
set(h,'pos',pos+[0 -40 0]) % Move label to right
j=ylabel('Depth from Surface [m]','FontSize',24);
posy=get(j,'pos');
set(j,'pos',posy+[40 0 0])
figdir='/Users/zhaozhang/frs124/GPR/submissions';
% Issue the print command, which does the same as "save" it
print('-dpdf','-bestfit',fullfile(figdir,'gpr03-fig.pdf'))