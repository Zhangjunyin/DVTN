
run('/home/zhangjunyin/DPVT_Code/matconvnet-1.0-beta25/matlab/vl_setupnn.m');
g=gpuDevice(3);
reset(g);
addpath('./common_plus/');
addpath('./function/');
video_path = '/home/zhangjunyin/DPVT_Code/baseline/highway/';
%path_cdnet = '~/dataset/dataset2014/';
im_pa = sprintf('%s%s', video_path,'input/');
gt_pa = sprintf('%s%s', video_path,'groundtruth/');
im_ft = 'jpg';
gt_ft = 'png';
sv_pa = ['./network/' video_path];
if ~exist(['./result/' video_path])
    mkdir(['./result/' video_path]);
end


len = 10;

global g_len g_epoch g_imMean;
g_len = len;
%imMean = getVideoMean_plus(im_pa);
imMean = 0;
%g_imMean = imMean;

                                                              %
g_epoch = 1;                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tic
temp = importdata(strcat(video_path,'temporalROI.txt'));
head_f = temp(1)
end_f  = temp(2)
length_f = end_f - head_f + 1;
blocks_num = fix((length_f-1) / (len*len)) + 1;
n_length_f = blocks_num*len*len;
array_tr = head_f + fix(blocks_num/2) : blocks_num : head_f + blocks_num*len*len - 1;

                                                     %
training_data = getTrainingData(im_pa, im_ft, gt_pa, gt_ft, array_tr, len,imMean);


network_training(sv_pa, training_data);
toc


%***************************************************************************



%CoreNum = 2;
%if isempty(gcp('nocreate'))
   % parpool;
%else
   % disp('parpool already started');
%end

%if mod(length_f,len*len)~=0
%    n_head_f = end_f - len*len*blocks_num + 1;
%    parfor i = 1:blocks_num
%        array_test   = n_head_f + i - 1 : blocks_num : end_f;
%        testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, array_test, len,imMean);
%        block_im     = network_testing(sv_pa, testing_data);                           %
%        [row_im column_im frames_t] = size(block_im);

%        disp('\nSaving result...\n');
%        for j = 1:frames_t
%            im = uint8(block_im(:,:,j));
%            imwrite(im,['./result/' video_path int2str(array_test(j)) '.bmp'],'bmp');
%        end
%    end
%end
for i = 1:blocks_num
    array_test   = head_f + i - 1 : blocks_num : head_f + blocks_num*len*len - 1;
    testing_data = getTestingData(im_pa, im_ft, gt_pa, gt_ft, array_test, len,imMean);
    block_im     = network_testing(sv_pa, testing_data);                           %
    [row_im column_im frames_t] = size(block_im);

    disp('\nSaving result...\n');
    for j = 1:frames_t
        im = uint8(block_im(:,:,j));
        %fgimg = thresholdImage(im,0.4*255);
        imwrite(im, ['./result/' video_path int2str(array_test(j)) '.bmp'],'bmp');
    end
    fprintf('%d / %d',i,blocks_num); 
end


%delete(gcp('nocreate'));

array_training = 1 + fix(blocks_num/2) : blocks_num : blocks_num*len*len;
n_array_training = array_training(array_training()<length_f+1);
test_result =  single(evaluation_translate(video_path,n_array_training))
fp = fopen('result.txt', 'a');
fprintf(fp,'%s\n%s\n',video_path,test_result);
fclose(fp);

