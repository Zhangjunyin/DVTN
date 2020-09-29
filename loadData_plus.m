function [files data] = loadData_plus(path,extention)

global g_height g_width g_imgdeep

if(path(end) ~= '/')
    path = [path '/'];
end

fprintf(1, 'Loading files from %s...\n', path);

files = dir([path '*.' extention]);
files = sort({files.name});

frames = size(files, 2);

sizes = size(imread([path files{1}]));


if(length(sizes) == 2)
    sizes(3) = 1; % Pretend we have a third dimension
end 

data = zeros([sizes, frames], 'uint8');
for tt = 1:frames
    fprintf(1, 'Reading file %d: %s\r', tt, files{tt});
    im = imread([path files{tt}]);
    data(:, :, :, tt) = im;
end
