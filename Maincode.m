
I = imread('Input.jpg');
size = 50;

k = input('Enter the number of clusters you want: ');
I1 = imresize(I,[size,size]);
w = zeros(size^2,size^2);
I2 = zeros(size+2,size+2);
I1 = double(I1);
I2(2:size+1,2:size+1) = I1;
vec = (1:size^2);
vec = reshape(vec,size^2,1);
[X,Y]=ind2sub([size,size],vec);
r=5;
sigmai=1;
sigmax=1;
I2 = (I2./255);




for i=1:size^2
    x1=X(i,1);
    y1=Y(i,1);
    
    for j=1:size^2
         if (i==j)
            w(i,j)=1;
         
         else
          
                 x2=X(j,1);
                 y2=Y(j,1);

            distance=((x1-x2)^2 + (y1-y2)^2); 
           
            if sqrt(distance)>=r
                a1=0;            
            else
                a1=exp(-((distance)/(sigmax^2)));
            end
            v1 = reshape(I2(x1:x1+2,y1:y1+2),1,9);
            v2 = reshape(I2(x2:x2+2,y2:y2+2),1,9);
            v = v1 - v2;
            V = v*v';
            
  
            
            a2=exp(-((V)/(sigmai)^2));  
            
            w(i,j)=a2*a1;
        end
    
    end
end


D = zeros(size^2,size^2);
for i = 1:2500
    D(i,i) = sum(w(1:size^2,i));
end

L = D-w;
[EVec,EVal] = eig(L,D);


matrix  = EVec(1:size^2,1:k);
idx = kmeans(matrix,k);
idx = reshape(idx,size,size);
result = mat2gray(idx);
figure;
imshow(result);
title('Clusters')
figure;
imshow(uint8(I1));
title('Input resized image')
figure;
imshow(I)
title('Original Input image')
disp(idx);






