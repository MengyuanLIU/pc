clc;
clear;

%Input data
% data=['A','E','H','K','M','w1';
%       'B','E','I','L','M','w1';
%       'A','G','I','L','N','w1';
%       'B','G','H','K','M','w1';
%       'A','G','I','L','M','w1';
%       'B','F','I','L','M','w2';
%       'B','F','J','L','N','w2';
%       'B','E','I','L','N','w2';
%       'C','G','J','K','N','w2';
%       'C','G','J','L','M','w2';
%       'D','G','J','K','M','w2';
%       'B','D','I','L','M','w2';]
%   A-0,B-1,C-2,D-3;
%   D-0,E-1,F-2,G-3;
%   H-0,I-1,J-2;
%   K-0,L-1;
%   M-0,N-1;
%   w1-1,w2-2;
data=[0,1,0,0,0,1;
      1,1,1,1,0,1;
      0,3,1,1,1,1;
      1,3,0,0,0,1;
      0,3,1,1,0,1;
      1,2,1,1,0,2;
      1,2,2,1,1,2;
      1,1,1,1,1,2;
      2,3,2,0,1,2;
      2,3,2,1,0,2;
      3,3,2,0,0,2;
      1,0,1,1,0,2;];
  bestlist=0;
  [tree bestlist]=id3(data,bestlist);
  
  best=bestlist(:,2:size(bestlist,2))
  test1=[1,3,1,0,1];
  test2=[2,0,2,1,0];
  class1=classifytree(test1,tree);
  class2=classifytree(test2,tree);
  disp(class1);
  disp(class2);