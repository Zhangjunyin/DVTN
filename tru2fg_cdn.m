function re_fgimg = tru2fg_cdn(img)

tempimg = img(:,:,1);

[row_img column_img byte_img] = size(tempimg);

re_fgimg = zeros(row_img,column_img);

index_bk = tempimg == 0;
index_fg = tempimg == 255;

re_fgimg = re_fgimg + 100;

re_fgimg(index_bk) = 0;
re_fgimg(index_fg) = 255;
