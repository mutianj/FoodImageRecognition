function computeDescriptorsFromImageList(name, data_dir, varargin)
NumNames = length(name);
opt.type = 'lbp';
opt = vl_argparse(opt, varargin) ;

switch opt.type
    case{'lbp'}
        lbpDescriptors = cell(1,NumNames);
        parfor i = 1:NumNames
            disp(i);
            im = imread(name{i});
            d = computeLBPMulti(im);
            lbpDescriptors{i} = vl_colsubset(d, 500, 'uniform');
        end

        cachePath = fullfile(data_dir, 'LBPDescriptors.mat') ;
        vl_xmkdir(data_dir);
        save(cachePath, 'lbpDescriptors', '-v7.3') ;
    case{'phow'}
        phowDescriptors = cell(1,NumNames);
        parfor i = 1:NumNames
            disp(i);
            im = imread(name{i});
            [~, d] = computePHOW(im);
            phowDescriptors{i} = vl_colsubset(d, 500, 'uniform');
        end

        cachePath = fullfile(data_dir, 'PhowDescriptors.mat') ;
        vl_xmkdir(data_dir);
        save(cachePath, 'phowDescriptors', '-v7.3') ;
end