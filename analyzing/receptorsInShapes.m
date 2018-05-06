
x=[1.2 5 10];
y=[150 20 10];
figure;
plot(x,y)
hold on
f=fit(x',y','exp1');
plot(f)

xx=1.2:0.01:5.4;
fun=f.a*exp(f.b.*xx);
num=sum(fun)*0.01
meanF=mean(fun)
plot(xx,fun)

FUN=@(x) f.a*exp(f.b*x);
Q = integral(FUN,1.2,5.4)
