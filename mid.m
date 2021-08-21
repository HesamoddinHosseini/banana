clear all
close all
pic = imread('9.jpg');
[rows, columns, numberOfColorChannels] = size(pic);
left = columns/2;
top = rows/2 ;
first = imcrop(pic, [0, 0, rows/3, columns]);
second= imcrop(pic, [rows/3, 0, rows/3, columns]);
third = imcrop(pic, [rows-100, 0, rows/3, columns]);
fourth = imcrop(pic, [rows+50, 0, rows/3, columns]);
figure
subplot(3,3,1);imshow(pic);
subplot(3,3,2);imshow(first);
subplot(3,3,3);imshow(second);
subplot(3,3,4);imshow(third);
subplot(3,3,5);imshow(fourth);

firstbw = im2bw(first);
firstbw = imcomplement(firstbw);
secondbw = im2bw(second);
secondbw = imcomplement(secondbw);
thirdbw = im2bw(third);
thirdbw = imcomplement(thirdbw);
fourthbw = im2bw(fourth);
fourthbw = imcomplement(fourthbw);

struct = strel('rectangle', [5,5]);
firstEroded = imopen(firstbw, struct);
secondEroded = imopen(secondbw, struct);
thirdEroded = imopen(thirdbw, struct);
fourthEroded = imopen(fourthbw, struct);

subplot(3,3,6);imshow(firstEroded);
subplot(3,3,7);imshow(secondEroded);
subplot(3,3,8);imshow(thirdEroded);
subplot(3,3,9);imshow(fourthEroded);

[first_function, first_count] = bwlabel(firstEroded);
[second_function, second_count] = bwlabel(secondEroded);
[third_function, third_count] = bwlabel(thirdEroded);
[fourth_function, fourth_count] = bwlabel(fourthEroded);

counts = [first_count, second_count, third_count, fourth_count];
texts = ["","","",""];

for i = 1:4
    if counts(i) < 5
        texts(i) = "??????";
    end
    if counts(i) > 5 && counts(i) < 20
        texts(i) = "?????";
    end
    if counts(i) > 20
        texts(i) = "????";
    end
end

figure;
subplot(2,2,1);imshow(first);title(texts(1))
subplot(2,2,2);imshow(second);title(texts(2))
subplot(2,2,3);imshow(third);title(texts(3))
subplot(2,2,4);imshow(fourth);title(texts(4))

