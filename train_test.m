%% =======================================================================
% Load the dataset in 4 variable:
% trainx: feature vectors, training set
% trainy: labels, training set
% testx: feature vectors, test set
% testy: labels, test set

% For machine fault diagnosis data
load('result_elgi_acoustic_healthy_liv_0.195.mat'); %path to data file
trainx=elgi_acoust_healthy(1:128,:);
trainx(129:256,:)=elgi_acoust_liv(1:128,:);
trainy(1:128,1)=1;
trainy(129:256,1)=0;
testx=elgi_acoust_healthy(129:256,:);
testx(129:256,:)=elgi_acoust_liv(129:256,:);
testy(1:128,1)=1;
testy(129:256,1)=0;

%% =============FEATURE SELECTION STRATEGY================================
%choose from one of the two feature selection algorithms: ITER, mRMR
%Uncomment only ONE of the sections below:

%Finding ITER indices:
for i = 1:285
    [err,thresh] = majorityvotefornumbers(trainx(:,i),trainy);
    fea_err(i) = sum(err);
end
[val, iter_fea_ind] = sort(fea_err);
data_ind = iter_fea_ind';

%Finding mRMR indices:
%data_ind = find_MI_ind(data,2,0.5,285);

%% ========= TRAINING CLASSIFIERS==========================================
%MVP classifier
fnum = 11; %Number of features to be used for classification
[err,thresh]=majorityvotefornumbers(trainx(:,data_ind(1:fnum)),trainy);
errorarr=finderror(trainx(:,data_ind(1:fnum)),trainy,thresh);
num_error_train=size(find(errorarr<ceil(fnum/2)+1),1);
train_acc = num_error_train/size(trainx,1);

errorarr=finderror(testx(:,data_ind(1:fnum)),testy,thresh);
num_error_test=size(find(errorarr<ceil(fnum/2)),1);
test_acc = num_error_test/size(testx,1);


