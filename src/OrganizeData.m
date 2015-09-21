clear;
clc;
close all;


DirName = '/Users/Ji/Documents/image';
OutDirName = '/Users/Ji/Documents/imageOrg';

if(~exist(OutDirName,'dir')); mkdir(OutDirName); end;

Categories = dir(DirName);

Count = 0;
for i = 4:length(Categories)
    Food = Categories(i).name;
    Jpegs = dir(fullfile(DirName,Food,'*.jpeg'));
    NumFiles = length(Jpegs);
    for j=1:NumFiles
        Count = Count + 1;
        disp(Count);
        Img = imread(fullfile(DirName,Food,Jpegs(j).name));
        [row,col,dim] =size(Img);
        if(dim==3 && sum(sum(Img(:,:,1)-Img(:,:,2))))
            copyfile(fullfile(DirName,Food,Jpegs(j).name),fullfile(OutDirName,[Food '_' Jpegs(j).name]));
        end
    end
    
end