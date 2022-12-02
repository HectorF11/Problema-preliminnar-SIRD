function [Z] = Preliminar(N)
Xn=[1; 0; 0; 0];
X=[Xn];
A=[0.95 0.04 0 0; 0.05 0.85 0 0; 0 0.1 1 0; 0 0.01 0 1];

for k=1:1:N-1
  Xn=A*Xn;
  X=[X,Xn];
endfor

  Y=[X,A*Xn];
  Y(:,1)=[];
  

    [r s t]=svd(X,"econ");
   
   #Recorte de filas y columnas generadas por errores de redondeo
   r=r(1:4,1:3);
   s=s(1:3,1:3);
   t=t(1:N,1:3);
   
   
   #Inversa de la matriz de valores singulares
   for k=1:1:3
     s(k,k)=1/s(k,k);
   endfor
   
   Ae=Y*t*s*r'
   disp(['||Ae X-Y||_F = ',num2str(norm(Ae*X-Y,'fro'))]);
   disp(['||Ae-A||_F = ',num2str(norm(Ae-A,'fro'))])
   
X0=[1; 0; 0; 0];
X1=X0;
for k = 1:1000
	X0 = [X0 A*X0(:,k)];
	X1 = [X1 Ae*X1(:,k)];
end

subplot(211);
plot(X0.');
title('Órbitas del modelo original')
axis([0, 1000, -0.1, 1])
set(gca, 'FontSize', 14)

subplot(212);
plot(X1.');
title('Órbitas del modelo aproximado')  
axis([0, 1000, -0.1, 1])
set(gca, 'FontSize', 14)  
  
