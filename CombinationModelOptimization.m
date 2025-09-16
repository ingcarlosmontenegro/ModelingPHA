clc % Limpia l a ventana de comandos
clear % Limpia todas l a s variables del espacio de trabajo
close a l l % Cierra todas l a s figuras
i n i t i a l _ s e a r c h _ p o i n t = [ 1 2 . 5 ] ; % Punto i n i c i a l de búsqueda para e l algoritmo de optimización
lower_bounds = [ 0 . 0 1 0 . 0 1 ] ; % Límites i n f e r i o r e s para l a s variables de decisión
upper_bounds = [100 1 0 0 ] ; % Límites superiores para l a s variables de decisión
% Ejecuta e l algoritmo de optimización ’ fmincon ’ para minimizar l a función de costo ’@fun’
x = fmincon (@fun, initial_search_point , [ ] , [ ] , [ ] , [ ] , lower_bounds , upper_bounds ) ;
opt = func ( x ) − 0 . 0 3 ; % Calcula l a función de costo óptima
otro1 = func ( [ 1 2 . 5 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro2 = func ( [ 0 . 2 2 . 5 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro3 = func ( [ 0 . 4 2 . 5 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro4 = func ( [ 0 . 8 2 . 5 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro5 = func ( [ 1 0 . 1 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro6 = func ( [ 1 0 . 2 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro7 = func ( [ 1 0 . 4 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
otro8 = func ( [ 1 0 . 8 ] ) − 0 . 0 3 ; % Calcula l a función de costo para otro punto
t = 0 : 0 . 0 0 2 5 : 7 2 ; % Vector de tiempo
% Grafica los resultados
figure ( 1 )
plot ( t , opt . / x ( 1 ) , ’ LineWidth ’ , 2) % Grafica l a función de costo óptima
hold on
grid on
grid minor
plot ( t , otro1 . / 1 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro2 . / 0 . 2 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro3 . / 0 . 4 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro4 . / 0 . 8 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
xlim ( [ 0 7 2 ] )
xlabel ( ’ Time [d] ’ )
ylabel ( ’PHA yie ld [g/g] ’ )
set ( gca , ’ FontSize ’ , 1 2 )
legend ( ’Optimo : S = 0.558 g/ L ; N = 4.4379 g/ L ’ , ’ S = 1 g/ L ; N = 2 . 5 g/ L ’ , ’ S = 0.2 g/ L ; N
= 2 . 5 g/ L ’ , ’ S = 0.4 g/ L ; N = 2 . 5 g/ L ’ , ’ S = 0.8 g/ L ; N = 2 . 5 g/ L ’ )
set ( gcf , ’ PaperUnits ’ , ’ centimeters ’ )
set ( gcf , ’ PaperSize ’ , [ 1 5 1 5 ] )
figure ( 2 )
plot ( t , opt . / x ( 1 ) , ’ LineWidth ’ , 2) % Grafica l a función de costo óptima
hold on
grid on
grid minor
plot ( t , otro5 . / 1 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro6 . / 1 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro7 . / 1 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
plot ( t , otro8 . / 1 , ’ LineWidth ’ , 2) % Grafica l a función de costo para otro punto
xlim ( [ 0 7 2 ] )
xlabel ( ’ Time [d] ’ )
ylabel ( ’PHA yie ld [g/g] ’ )
set ( gca , ’ FontSize ’ , 1 2 )
legend ( ’Optimo : S = 0.558 g/ L ; N = 4.4379 g/ L ’ , ’ S = 1 g/ L ; N = 0 . 1 g/ L ’ , ’ S = 1 g/ L ; N =
0.2 g/ L ’ , ’ S = 1 g/ L ; N = 0.4 g/ L ’ , ’ S = 1 g/ L ; N = 0.8 g/ L ’ )
set ( gcf , ’ PaperUnits ’ , ’ centimeters ’ )
set ( gcf , ’ PaperSize ’ , [ 1 5 1 5 ] )
% Función de costo para l a optimización
function maximo = fun ( con )
y = func ( con ) ; % Calcula l a función de costo
maximo = ( − (max( y ) − 0.03) ) / con ( 1 ) ; % Calcula e l valor de l a función objetivo
end
% Función que calcula l a función de costo en función de los parámetros de entrada
function out = func ( con )
% Define los parámetros
pars = [0.4700 0.2123 0.0009 199.9041 23.6515 1 . 1 6 5 4 6.0147 5.9450 0.1056 0.7880 2.0099
0.9448];
So = con ( 1 ) ;
No = con ( 2 ) ;
Xo = 0 . 0 5 ;
Po = 0 . 0 3 ;
V = 7 ; % Volumen del reactor
F1 = 0 ; % Ratio de f l u j o de nitrógeno
F2 = 0 ; % Ratio de f l u j o de sustrato − VFA− AGV
umax = pars ( 1 ) ;
Ks = pars ( 2 ) ;
Kn = pars ( 3 ) ;
Sm = pars ( 4 ) ;
Nm = pars ( 5 ) ;
Pm = pars ( 6 ) ;
a1 = pars ( 7 ) ;
a2 = pars ( 8 ) ;
a3 = pars ( 9 ) ;
a l f = pars ( 1 2 ) ;
ms = 0.0016;
mn = 0 . 0 0 1 5 ;
Yxs = pars ( 1 0 ) ;
Yxn = pars ( 1 1 ) ;
SF = 0 ;
NF = 0 ;
y0 = [ Xo So No Po ] ;
t 1 = [0 7 2 ] ;
Ts = 0 . 0 1 ;
options_sim = odeset ( ’MaxStep ’ , Ts ) ;
[ t , y ] = ode45 (@( t , y ) odefcnPHA6( t , y , V , F1 , F2 , umax, a1 , a2 , a3 , Ks , Kn, Sm, Nm, Pm,
SF , Yxs , ms, NF, mn, a l f , Yxn ) , t 1 , y0 , options_sim ) ;
out = r e a l ( y ( : , 4) ) ; % Devuelve e l valor de l a concentración de PHA
out ( isnan ( out ) ) = 0 ; % Reemplaza NaN por 0
out ( i s i n f ( out ) ) = 10000; % Reemplaza I n f por 10000
end
