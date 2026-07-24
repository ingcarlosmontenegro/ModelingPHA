% Limpiar e l entorno de trabajo
clc
clear
close all
% Cargar datos desde un archivo MSData .mat
load MSData .mat
% Definir e l vector de tiempo de muestreo
time = 0 : 6 : 7 2 ;
% Condiciones i n i c i a l e s de Biomasa y PHA
DB0 = 0 . 0 5 ;
DPHA0 = 0 . 0 3 ;
% Número de Combinación
NumC = 1 ;
% Extraer datos de biomasa y PHA desde e l archivo de datos
DB = [DB0; DataBiomasa ( 2 : end , NumC+ 1 ) ] ;
DPHA = [DPHA0; DataPHA ( 2 : end , NumC+ 1 ) ] ;
% Definir tiempos específicos para los datos experimentales
t 1 = [0 6 18 24 31 43 48 54 66 7 2 ] ;
% Datos experimentales de Biomasa , PHA, Sustrato y Nitrógeno
XR = [ 2 . 1 2 . 5 1 3.49 3.80 5.02 6.52 6.67 6.70 6.65 5 . 4 2 ] ;
PR = [ 1 . 2 1 . 5 4 2.57 2.26 3.39 4.05 4.97 5.25 4.80 3 . 5 0 ] ;
SR = [5.00 4 . 1 3 2.00 1.08 1.08 0.00 0.00 0.00 0.00 0 . 0 0 ] ;
NR = [ 2 . 4 1 2.36 2.08 1 . 6 9 1 . 0 3 0.84 0.44 0 . 1 3 0 . 1 2 0 . 1 6 ] ;
% Condiciones i n i c i a l e s del sistema
So = 5 ;
No = 2 . 4 1 ;
Xo = 2 . 1 ;
Po = 1 . 2 ;
% Parámetros del modelo
V = 7 ; % Volumen del reactor
F1 = 0 ; % Flujo de nitrógeno
F2 = 0 ; % Flujo de sustrato
umax = 0 . 0 7 ;
Ks = 3 . 3 5 ;
Kn = 0.036;
Sm = 1 9 1 . 3 2 ;
Nm = 1 5 . 4 7 ;
Pm = 1 4 . 6 2 ;
a1 = 2 . 6 ;
a2 = 1 0 . 2 3 ;
a3 = 1 . 1 6 3 ;
a l f = 0 . 9 2 ;
ms = 0.0016;
mn = 0 . 0 0 1 5 ;
Yxs = 0 . 8 9 ;
d = 9 . 3 2 ;
b = 0 . 1 3 1 4 ;
CN = 7 . 0 3 ; % Concentración de nitrógeno
SF = 0 ; % Concentración de acetato en l a solución de alimentación
NF = 0 ; % Concentración de nitrógeno de amonio en l a solución de alimentación
% Definir e l paso de tiempo para l a integración
Ts = 0 . 0 1 ;
options_sim = odeset ( ’MaxStep ’ , Ts ) ;
% Definir e l intervalo de tiempo para l a integración
tspan = [0 7 2 ] ;
% Condiciones i n i c i a l e s para l a s variables de estado
y0 = [ Xo So No Po ] ;
% Resolver l a s ecuaciones diferenciales usando e l método de integración ode78
[ t , y ] = ode78 (@( t , y ) odefcnPHA4( t , y , V , F1 , F2 , umax, a1 , a2 , a3 , Ks , Kn, Sm, Nm, Pm, SF ,
Yxs , ms, NF, mn, a l f , CN, d , b) , tspan , y0 , options_sim ) ;
% Extraer los resultados simulados de Biomasa , Sustrato , Nitrógeno y PHA
X = r e a l ( y ( : , 1 ) ) ;
S = r e a l ( y ( : , 2) ) ;
N = r e a l ( y ( : , 3) ) ;
P = r e a l ( y ( : , 4) ) ;
% Graficar los resultados
figure
plot ( t , X , ’ LineWidth ’ , 2)
hold on
grid on
grid minor
plot ( t 1 , XR, ” ^ ” , ’ LineWidth ’ , 2)
plot ( t , S , ’ LineWidth ’ , 2)
plot ( t 1 , SR , ” square ” , ’ LineWidth ’ , 2)
plot ( t , N, ’ LineWidth ’ , 2)
plot ( t 1 , NR, ” ^ ” , ’ LineWidth ’ , 2)
plot ( t , P , ’ LineWidth ’ , 2)
plot ( t 1 , PR, ” square ” , ’ LineWidth ’ , 2)
xlim ( [ 0 7 2 ] )
xlabel ( ’ t (h) ’ , ’ Interpreter ’ , ’ latex ’ )
ylabel ( ’ Concentracion (g/ L ) ’ , ’ Interpreter ’ , ’ latex ’ )
legend ( ’ Biomasa sim ’ , ’ Biomasa ’ , ’ Sustrato sim ’ , ’ Sustrato ’ , ’ Nitrogeno sim ’ , ’ Nitrogeno ’ , ’
PHA sim ’ , ’PHA ’ , ’ Interpreter ’ , ’ latex ’ )
set ( gca , ’ fontsize ’ , 1 4 )
