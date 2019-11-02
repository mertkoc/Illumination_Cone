%%
% koc.15 Hw 4
%%
% Code creates two video files which you can play at the current directory
% of the .m file. Example videos are available with names "Fullcoverage"
% and "SpotlightsOnme". Photos were taken by me :)) Additionally before
% running, remember to adjust increment as it may take too long.

workingDir = pwd;
im1 = imread('IMG_1515.jpg');
im2 = imread('IMG_1516.jpg');
im3 = imread('IMG_1517.jpg');


im1_gray = rgb2gray(im1);
im2_gray = rgb2gray(im2);
im3_gray = rgb2gray(im3);


resize_ratio = [400 400];

im1_resized = imresize(im1_gray,resize_ratio);
im2_resized = imresize(im2_gray,resize_ratio);
im3_resized = imresize(im3_gray,resize_ratio);


im1_vec = im1_resized';
im1_vec = im1_vec(:);
im2_vec = im2_resized';
im2_vec = im2_vec(:);
im3_vec = im3_resized';
im3_vec = im3_vec(:);

T = double([im1_vec';im2_vec';im3_vec']);

[U,S,V] = svd((T*T'));
%%
B = T'*V*sqrt(inv(S));
%%
increment = 10*pi/180;
outputVideo = VideoWriter(fullfile(workingDir,'Fullcoverage.avi'));
outputVideo.FrameRate = 60;
open(outputVideo)


for phi = 0:increment:pi
    for theta = 0:increment:pi
        
        s = [cos(theta)*sin(phi) sin(theta)*sin(phi) cos(phi)]';
        b = max([B*s zeros(length(B(:,1)),1)],[],2);
        img = vec2mat(b,length(im1_resized(1,:)));
        img = mat2gray(img);
        writeVideo(outputVideo,img)
    end
end


close(outputVideo)

outputVideo = VideoWriter(fullfile(workingDir,'SpotlightsOnme.avi'));
outputVideo.FrameRate = 60;
open(outputVideo)

theta = pi;
for phi = 0:increment:pi
        
        s = [cos(theta)*sin(phi) sin(theta)*sin(phi) cos(phi)]';
        b = max([B*s zeros(length(B(:,1)),1)],[],2);
        img = vec2mat(b,length(im1_resized(1,:)));
        img = mat2gray(img);
        writeVideo(outputVideo,img)
end



close(outputVideo)

% shuttleAvi = VideoReader(fullfile(workingDir,'trial.avi'));

% ii = 1;
% while hasFrame(shuttleAvi)
%     mov(ii) = im2frame(readFrame(shuttleAvi));
%     ii = ii+1;
% end
% 
% figure
% imshow(mov(1).cdata, 'Border', 'tight')
% movie(mov,1,shuttleAvi.FrameRate)

% close(outputVideo)