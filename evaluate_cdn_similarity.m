function re_simvalue = evaluate_cdn_similarity(files_sim,data_sim,files_tru,data_tru,threshold_fg)


[row_img column_img byte_img frames_img] = size(data_sim);
[row_tru column_tru byte_tru frames_tru] = size(data_tru);

pos = 1;

all_TP = 0;
all_FP = 0;
all_FN = 0;
all_TN = 0;

re_simentry = [];



global g_displayMatrixImage;
g_displayMatrixImage = 1;


for i = 1:frames_img
	img = double(data_sim(:,:,:,i));
	%img_name = files_sim{i};


	tru = double(data_tru(:,:,:,pos));

	trufgimg = tru2fg_cdn(tru);

        fgimg = thresholdImage(img,threshold_fg*255);
              
%    fgimg = img(:,:,1);


%    fgimg = img(:,:,1);

	[TP FP FN TN] = evalution_entry(fgimg,trufgimg);

%	re_simentry = [re_simentry; TP FP FN TN];
	all_TP = all_TP + TP;
	all_FP = all_FP + FP;
	all_FN = all_FN + FN;
	all_TN = all_TN + TN;

%	[i all_TP all_FP all_FN all_TN ]

%    img_name
%    files_tru{pos}
%    [TP FP FN TN]
%    [all_TP all_FP all_FN all_TN]

%    displayMatrixImage(1,2,2,img,tru,fgimg,trufgimg)

    pos = pos + 1;
%    input('pause')
end

re_simvalue = [all_TP all_FP all_FN all_TN];

