function patch = img2pix_plus(im_pa,im_ft, im_array, len, im_flag,im_Mean)

%==============================================================================
% Author: Ryan  
% DATE: 2017/05/17
% inputDir: the Dir of your opt-flow data 
% extention: 'jpg','bmp'
% outputPath: where to save opt-flow image
% dataName: theName of the vedio
% descript: This function will make a new form of pixel-motion data base on videos.
% 
% Reviser: HalfofStupid
% ===========================================================================
imMean = im_Mean;


%mask = imread([im_pa 'ROI.bmp']);
%if  mean(mean(mask)) == 255
%    f_mask = 0;
%else
%    f_mask = 1;
%end

%if strcmp(im_ft,'jpg')
%    mask = repmat(mask,[1,1,3]);
%end


[fs ffs] = loadFiles_plus(im_pa, im_ft);
ft_idx = im_array;
[row_im column_im byte_im] = size(single(imread(ffs{1})));
block_im = zeros(row_im, column_im, byte_im, len^2);
lengthF = size(ffs,2);
for i = 1:numel(ft_idx)
    idx = ft_idx(i);
    if idx<lengthF+1
        im = double(imread(ffs{idx}));
    else
        im = double(imread(ffs{1}));
        im(:,:,:) = 0;
    end
%    if f_mask == 1
%        im(mask ~= 255) = 0;
%    end
    block_im(:,:,:,i) = im;
end


%if im_flag == 1
%    imMean(mask ~= 255) = 0;
%    imMean = repmat(imMean,[1,1,1,len*len]);
%    block_im = abs (block_im - imMean);
%else
%    block_im = 255 - block_im;
%end

block_im = permute(block_im,[4 3 2 1]);
patch = reshape(block_im,len,len,byte_im,row_im*column_im);





