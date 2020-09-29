function [ file ] = sortObj(file)

[~, ind]=natsortfiles(file);
for j=1:length(file)
    files{j}=file{ind(j)};
end
clear file;
file=files;
end

