% Limpiar l a ventana de comandos, eliminar variables del espacio de trabajo y cerrar todas
l a s figuras
clc
clear
close all
% Cargar datos experimentales desde e l archivo MSData .mat
load MSData .mat
% Definir e l vector de tiempo de muestreo
time = 1 2 : 1 2 : 7 2 ;
% Condiciones i n i c i a l e s de Biomasa y PHA
DB0 = 0 . 0 5 ;
DPHA0 = 0 . 0 3 ;
% Número de Combinación
NumC = 1 ;
% Extraer datos de biomasa y PHA desde e l archivo de datos
DB = [ DataBiomasa ( 2 : end , NumC+ 1 ) ] ;
DPHA = [DataPHA ( 2 : end , NumC+ 1 ) ] ;
% Combinar datos de biomasa y PHA en una matriz de datos
data = [DB DPHA] ;
% Definir opciones para e l ajuste no l i n e a l
opts = statset ( ’ n l i n f i t ’ ) ;
options = optimoptions ( ’ l s q c u r v e f i t ’ , ’ Display ’ , ’ i t e r −detailed ’ , ’ MaxIterations ’ , 150 , ’
StepTolerance ’ , 1 e − 1 2 , ” DiffMinChange ” , 0.001 , ’ FunctionTolerance ’ , 1 e−20 , ’
OptimalityTolerance ’ , 1 e−20 , ’ MaxFunctionEvaluations ’ , 10000) ;
% Establecer valores i n i c i a l e s para los parámetros del modelo
parguess = [0.02 0.5 0.254 200 20 20 3 4 1 0.89 2 0 . 9 2 ] ; % Se necesitan valores i n i c i a l e s
para los ajustes no l i n e a l e s
% Realizar e l ajuste de curva utilizando l s q c u r v e f i t
x = l s q c u r v e f i t (@func2 , parguess , time , data , [0.0001 0.0001 0.0001 0.0001 0.0001 0.0001
0.0001 0.0001 0.0001 0.0001 0.0001] , [0.47 100 100 200 200 200 100 100 100 100 1 0 ] ,
options ) ;
% Generar datos simulados utilizando los parámetros ajustados
t f i t = linspace ( 0 , 72) ;
f i t = func3 ( x , t f i t ) ;
% Definir tiempos específicos para los datos experimentales
time2 = 0 : 1 2 : 6 0 ;
% Graficar resultados
figure ( 1 )
plot ( t f i t , f i t ( : , 1 ) , ’ LineWidth ’ , 2)
hold on
grid on
grid minor
plot ( time2 , DB, ” ^ ” , ’ LineWidth ’ , 2)
plot ( t f i t , f i t ( : , 4) , ’ LineWidth ’ , 2)
plot ( time2 , DPHA, ” square ” , ’ LineWidth ’ , 2)
xlim ( [ 0 7 2 ] )
xlabel ( ’ t (h) ’ , ’ Interpreter ’ , ’ latex ’ )
ylabel ( ’ Concentracion (g/ L ) ’ , ’ Interpreter ’ , ’ latex ’ )
legend ( ’ Biomasa sim ’ , ’ Biomasa ’ , ’PHA sim ’ , ’PHA ’ , ’ interpreter ’ , ’ latex ’ )
set ( gca , ’ fontsize ’ , 1 4 )
set ( gcf , ’ PaperUnits ’ , ’ centimeters ’ )
set ( gcf , ’ PaperSize ’ , [20 1 5 ] )
% Graficar resultados con sustrato y nitrógeno
figure ( 2 )
plot ( t f i t , f i t ( : , 1 ) , ’ LineWidth ’ , 2)
hold on
grid on
grid minor
plot ( time2 , DB, ” ^ ” , ’ LineWidth ’ , 2)
plot ( t f i t , f i t ( : , 4) , ’ LineWidth ’ , 2)
plot ( time2 , DPHA, ” square ” , ’ LineWidth ’ , 2)
plot ( t f i t , f i t ( : , 2) , ’ LineWidth ’ , 2)
plot ( t f i t , f i t ( : , 3) , ’ LineWidth ’ , 2)
xlim ( [ 0 7 2 ] )
xlabel ( ’ t (h) ’ , ’ Interpreter ’ , ’ latex ’ )
ylabel ( ’ Concentracion (g/ L ) ’ , ’ Interpreter ’ , ’ latex ’ )
legend ( ’ Biomasa sim ’ , ’ Biomasa ’ , ’PHA sim ’ , ’PHA ’ , ’ Sustrato ’ , ’ Nitrogeno ’ , ’ interpreter ’ , ’
latex ’ )
set ( gca , ’ fontsize ’ , 1 4 )
set ( gcf , ’ PaperUnits ’ , ’ centimeters ’ )
set ( gcf , ’ PaperSize ’ , [20 1 5 ] )
% Definir l a función de ajuste no l i n e a l
function out = func2 ( pars , t 1 )
% Parámetros f i j o s de biomasa y PHA
DB = [0.058333333333345; 0.300000000000041; 0.416666666666732; 0.499999999999871;
0.508333333333333; 0.633333333333338];
DPHA = [0.033333333333333; 0.283333333333333; 0.370000000000000; 0.450000000000000;
0.433333333333333; 0.580000000000000];
% Condiciones i n i c i a l e s
So = 1 ;
No = 2 . 5 ;
Xo = DB( 1 ) ;
Po = DPHA( 1 ) ;
% Parámetros del modelo
V = 7 ; % Volumen del reactor
F1 = 0 ; % Ratio de Flujo de nitrógeno
F2 = 0 ; % Ratio de Flujo de sustrato
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
% Condiciones i n i c i a l e s
y0 = [ Xo So No Po ] ;
Ts = 0 . 1 ;
options_sim = odeset ( ’MaxStep ’ , Ts ) ;
% Resolver ecuaciones diferenciales
[ t , y ] = ode45 (@( t , y ) odefcnPHA6( t , y , V , F1 , F2 , umax, a1 , a2 , a3 , Ks , Kn, Sm, Nm, Pm,
SF , Yxs , ms, NF, mn, a l f , Yxn ) , t 1 , y0 , options_sim ) ;
% Extraer resultados en tiempos específicos
indices_tiempo_especifico = zeros ( length ( t 1 ) , 1 ) ;
f o r i = 1 : length ( t 1 )
[ ~ , idx ] = min( abs ( t − t 1 ( i ) ) ) ;
indices_tiempo_especifico ( i ) = idx ;
end
% Salida de l a función
out ( : , 1 ) = r e a l ( y ( indices_tiempo_especifico , 1 ) ) ;
out ( : , 2) = r e a l ( y ( indices_tiempo_especifico , 4) ) ;
out ( isnan ( out ) ) = 0 ; % Reemplazar NaN por 0
out ( i s i n f ( out ) ) = 10000; % Reemplazar I n f por 10000
end
% Definir otra función de ajuste no l i n e a l
function out = func3 ( pars , t 1 )
% Parámetros f i j o s de biomasa y PHA
DB = [0.058333333333345; 0.300000000000041; 0.416666666666732; 0.499999999999871;
0.508333333333333; 0.633333333333338];
DPHA = [0.033333333333333; 0.283333333333333; 0.370000000000000; 0.450000000000000;
0.433333333333333; 0.580000000000000];
% Condiciones i n i c i a l e s
So = 1 ;
No = 2 . 5 ;
Xo = DB( 1 ) ;
Po = DPHA( 1 ) ;
% Parámetros del modelo
V = 7 ; % Volumen del reactor
F1 = 0 ; % Ratio de Flujo de nitrógeno
F2 = 0 ; % Ratio de Flujo de sustrato
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
% Condiciones i n i c i a l e s
y0 = [ Xo So No Po ] ;
Ts = 0 . 1 ;
options_sim = odeset ( ’MaxStep ’ , Ts ) ;
% Resolver ecuaciones diferenciales
[ t , y ] = ode45 (@( t , y ) odefcnPHA6( t , y , V , F1 , F2 , umax, a1 , a2 , a3 , Ks , Kn, Sm, Nm, Pm,
SF , Yxs , ms, NF, mn, a l f , Yxn ) , t 1 , y0 , options_sim ) ;
% Salida de l a función
out = y ;
end
