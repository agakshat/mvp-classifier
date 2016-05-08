function [errorarr]=finderror(testdata,testclass,threshold)
	%threshold is a matrix, with number of rows equal to number of features and
	%2 columns. each value is the threshold value for that feature as obtained
	%from training.
	n=size(threshold,1); %number of features
	errorarr=zeros(size(testdata,1),1);
	for i=1:n
		predictarr=zeros(size(testdata,1),1);
		if (threshold(i,1)==0)
			predictarr(testdata(:,i)>=threshold(i,2))=0;
			predictarr(testdata(:,i)<threshold(i,2))=1;
		else
			predictarr(testdata(:,i)>threshold(i,2))=1;
			predictarr(testdata(:,i)<=threshold(i,2))=0;
		end
		for j=1:size(errorarr,1)
			errorarr(j)=errorarr(j)+(predictarr(j)==testclass(j));
		end
		
	end

end 