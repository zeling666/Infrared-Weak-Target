function re = dlcmfunc(img,length)
img = double(img);
[row, col] = size(img);
len = length;
nr = 5;
nc = 5;
leny = len*nr;
lenx=  len*nc;
op = zeros(leny, lenx, nr*nc);
for ii = 1:nr*nc    
    temp = zeros(len*nr,  len*nc);
    [r, c]  = ind2sub([nr, nc], ii);
    temp((r-1)*len + 1:r*len, (c-1)*len+1:c*len) = 1;
    temp = temp/sum(temp(:));
    temp = temp';
    op(:, :, ii) = temp;
end
%%
gimg = zeros(row, col, nr*nc);
for ii = 1:nr*nc
    gimg(:, :, ii) = imfilter(img, op(:,:, ii), 'replicate');
end
m1 = gimg;
m2 = gimg;
m1(:,:, [7:9, 12:14, 17:19]) = [];
t1 = repmat(gimg(:, :, 13), 1,1,16) - m1;
t1(t1<=0) = 0;
d1 = min(t1, [], 3);
%%%%%%%%%%%%%%%%%%%
tt1 = repmat(gimg(:, :, 7), 1,1,3) - m2(:,:, [2,6,12]);tt1(tt1<=0) = 0;
tt2 = repmat(gimg(:, :, 8), 1,1,3) - m2(:,:, [3,9,7]);tt2(tt2<=0) = 0;
tt3 = repmat(gimg(:, :, 9), 1,1,3) - m2(:,:, [4,10,14]);tt3(tt3<=0) = 0;
tt4 = repmat(gimg(:, :, 12), 1,1,2) - m2(:,:, [11,17]);tt4(tt4<=0) = 0;
tt5 = repmat(gimg(:, :, 14), 1,1,2) - m2(:,:, [15,19]);tt5(tt5<=0) = 0;
tt6 = repmat(gimg(:, :, 17), 1,1,2) - m2(:,:, [16,22]);tt6(tt6<=0) = 0;
tt7 = repmat(gimg(:, :, 18), 1,1,2) - m2(:,:, [19,23]);tt7(tt7<=0) = 0;
tt8 = repmat(gimg(:, :, 19), 1,1,2) - m2(:,:, [20,24]);tt8(tt8<=0) = 0;
%%
c1 = gimg(:,:,13) - gimg(:,:,7); c1(c1<=0) = 0;
c2 = gimg(:,:,13) - gimg(:,:,8); c2(c2<=0) = 0;
c3 = gimg(:,:,13) - gimg(:,:,9); c3(c3<=0) = 0;
c4 = gimg(:,:,13) - gimg(:,:,12); c4(c4<=0) = 0;
c5 = gimg(:,:,13) - gimg(:,:,14);  c5(c5<=0) = 0;
c6 = gimg(:,:,13) - gimg(:,:,17); c6(c6<=0) = 0;
c7 = gimg(:,:,13) - gimg(:,:,18); c7(c7<=0) = 0;
c8 = gimg(:,:,13) - gimg(:,:,19); c8(c8<=0) = 0;
dot1 = c1.*c8;
dot2 = c2.*c7;
dot3 = c3.*c6;
dot4 = c4.*c5;

e1 = c1 - tt1;e1(e1<=0) = 0;
e2 = c2 - tt2;e2(e2<=0) = 0;
e3 = c3 - tt3;e3(e3<=0) = 0;
e4 = c4 - tt4;e4(e4<=0) = 0;
e5 = c5 - tt5;e5(e5<=0) = 0;
e6 = c6 - tt6;e6(e6<=0) = 0;
e7 = c7 - tt7;e7(e7<=0) = 0;
e8 = c8 - tt8;e8(e8<=0) = 0;
t3 = cat(3, e1, e2, e3, e4,e5,e6,e7,e8);
d3 = min(t3, [], 3);



t2 = cat(3, dot1, dot2, dot3, dot4);
d2 = min(t2, [], 3);
re = d2 .* d1.* d3;
end
