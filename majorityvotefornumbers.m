function [a,threshold]=majorityvotefornumbers(A,B) %A is featuredata, B is classinfo
% a returns information about number of correct classifications
% threshold returns information for testing error
% err=A(51:end,:);
% a=zeros(size(err,1),1);
a=zeros(size(A,1),1);
threshold=zeros(size(A,2),2);
%errorarr=zeros(size(A,2),1);
for i=1:size(A,2)
   % X=A(51:end,i);
    X=A(:,i);
  %  Y=B(51:end);
  Y=B;
   % lda=fitcdiscr(X,Y,'discrimType','pseudoLinear');
   % ldaClass=resubPredict(lda);
   [ldaClass,threshold(i,:)]=findMIE2(Y,X);
    for j=1:size(A,1)
        a(j)=a(j)+ (ldaClass(j)==B(j));
    end
    
end
