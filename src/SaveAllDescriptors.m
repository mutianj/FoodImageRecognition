setup;
image_dir = '/Users/Ji/Documents/imageOrg';
data_dir = strcat(image_dir, 'data');

% class_list = {'apple';'banana';'broccoli';'burger';'cookie';'egg';'frenchfry';'hotdog';
%    'pasta';'pizza';'rice';'salad';'strawberry';'tomato'};
%
% NumFiles = length(dir(fullfile(image_dir,'*.jpeg')));
% 
% name = cell(NumFiles,1);
% label = NaN * ones(NumFiles,1);
% NumImgs = NaN * ones(14,1);
% Count = 0;
% for i=1:14
%     ClassNames = dir(fullfile(image_dir,[class_list{i} '*.jpeg*']));
%     NumImgs(i) = length(ClassNames);
%     for j=1:NumImgs(i)
%         Count  = Count + 1;
%       name{Count,1}=fullfile(image_dir,ClassNames(j).name);
%       label(Count) = i;
%     end
% end
%%
load('NameLabels_Subset_Xinge.mat'); % name, label;

computeDescriptorsFromImageList(name, data_dir, 'type','phow');
computeDescriptorsFromImageList(name, data_dir, 'type','lbp');
computeColorHistogram(name, data_dir, 'ColorDescritpors');



