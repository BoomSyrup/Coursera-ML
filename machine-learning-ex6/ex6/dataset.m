cd('spam_2');
files = ls;
cd ..
spams = [];
[r c]=size(files);
for i = 1:r
	printf("Processing example %d/%d...\n",i,r);
	fflush(stdout);
	ext = files(i,:);
	file = strcat("spam_2\/",ext);
	spams = [spams emailFeatures(processEmail(readFile(file)))];
endfor
cd('easy_ham_2');
files = ls;
cd ..
emails = [];
[r2 c2]=size(files);
for i = 1:r2
	printf("Processing example %d/%d...\n",i,r2);
	fflush(stdout);
	ext = files(i,:);
	file = strcat("easy_ham_2\/",ext);
	emails = [emails emailFeatures(processEmail(readFile(file)))];
endfor
X = [emails spams];
y = [zeros(r2,1) ; ones(r,1)];
m = size(X, 2);
sel = randperm(m);
sel_train = sel(1:floor(m * 0.6));
sel_val = sel(floor(m*0.6) + 1:end);
X_train = X(:,sel_train);
y_train = y(sel_train);
X_val = X(:,sel_val);
y_val = y(sel_val);

X = X_train';
Xtest = X_val';
y = y_train;
ytest = y_val;


save spamTrain.mat X y;
save spanTest.mat Xtest ytest;
