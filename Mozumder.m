clc % Limpia l a ventana de comandos
clear % Borra todas l a s variables del área de trabajo
close a l l % Cierra todas l a s figuras abiertas anteriormente
% Condiciones i n i c i a l e s
So = 1 . 5 ; % Concentración i n i c i a l de sustrato (g/ L )
No = 0 . 1 2 9 8 ; % Concentración i n i c i a l de nitrógeno (g/ L )
Xo = 0 . 5 ; % Concentración i n i c i a l de biomasa (g/ L )
Xho = 0 ; % Concentración i n i c i a l de biomasa no productora (g/ L )
Po = 0 ; % Concentración i n i c i a l de PHA (g/ L )
V = 1 0 ; % Volumen del reactor ( L )
FN = 0 ; % Flujo de nitrógeno (g/h)
FS = 0 ; % Flujo de sustrato (g/h)
F = FS + FN ; % Flujo t o t a l (g/h)
D = F /V ; % Tasa de dilución ( 1 / h)
SF = 0 ; % Concentración de acetato en l a solución de alimentación (g/ L )
NF = 0 ; % Concentración de nitrógeno de amonio en l a solución de
alimentación (g/ L )
% Parámetros del modelo
uxsmax = 0 . 1 1 ; % Velocidad máxima de crecimiento específico de biomasa (g
célula /g célula /h)
uxhsmax = 0 . 4 7 ; % Velocidad máxima de crecimiento específico de biomasa PHA (g
célula /g célula /h)
uprodmax = 2 . 5 5 ; % Velocidad máxima de producción de PHA (g PHA/g célula /h)
uxphamax = 0 . 5 2 ; % Velocidad máxima de consumo de PHA (g célula /g célula /h)
Kxs = 0.00186; % Constante de saturación de sustrato para e l crecimiento de
biomasa (g acetato / L )
Kn = 0.254; % Constante de saturación de nitrógeno (g N/ L )
Kxhs = 0.00186; % Constante de saturación de sustrato para e l crecimiento de
biomasa PHA (g acetato / L )
Knh = 0.254; % Constante de saturación de nitrógeno para e l crecimiento de
biomasa PHA (g N/ L )
Kps = 0.00186; % Constante de saturación de sustrato para l a producción de PHA
(g acetato / L )
Kpin = 2 . 1 ; % Constante de saturación de nitrógeno para l a producción de PHA
(g N/ L )
Kxpha = 0.00009; % Constante de saturación de PHA para e l crecimiento de biomasa
(g PHA/g célula )
Kis = 0 . 2 2 ; % Constante de inhibición de sustrato (g/ L )
yxs = 0 . 4 7 ; % Rendimiento en biomasa respecto a l sustrato (g célula /g
acetato )
yxhs = 0 . 4 7 ; % Rendimiento en biomasa PHA respecto a l sustrato (g célula /g
acetato )
yps = 0.48; % Rendimiento en PHA respecto a l sustrato (g PHA/g acetato )
yxn = 9 . 0 9 ; % Rendimiento en biomasa respecto a l nitrógeno (g célula /g N)
yxp = 0 . 8 1 ; % Rendimiento en biomasa respecto a l PHA (g célula /g PHA)
yatps = 8 . 4 5 ; % Rendimiento en ATP respecto a l sustrato (g ATP/g acetato )
yatppha = 1 3 . 0 9 ; % Rendimiento en ATP respecto a l PHA (g ATP/g PHA)
Sm = 1 3 . 4 ; % Concentración de sustrato (g/ L )
C = 0 . 8 9 ; % Coeficiente adimensional
fphamax = 2 . 4 7 ; % Fracción máxima de PHA en células (g PHA/g célula )
a l f = 3 . 8 5 ; % Coeficiente adimensional
matp = 0 . 1 1 0 5 ; % Masa de ATP (g ATP/g célula /h)
Ts = 0 . 0 1 ; % Paso de tiempo para l a simulación (h)
options_sim = odeset ( ’MaxStep ’ , Ts ) ; % Opciones para l a simulación de ODE
tspan = [0 1 5 ] ; % Tiempo de simulación (h)
y0 = [ So No Xo Xho Po ] ; % Condiciones i n i c i a l e s del sistema de ODE
[ t , y ] = ode23 (@( t , y ) odefcnPHA( t , y , V , FS , FN, SF , NF, uxsmax , uxhsmax , uprodmax,
uxphamax, Kxs , Kn, Kxhs , Knh, Kps , Kpin , Kxpha , Kis , yxs , yxhs , yps , yxn , yxp , yatps ,
yatppha , Sm, C , fphamax , a l f , matp) , tspan , y0 , options_sim ) ; % Simulación de ODE
S = y ( : , 1 ) ; % Concentración de sustrato
N = y ( : , 2) ; % Concentración de nitrógeno
X = y ( : , 3) ; % Concentración de biomasa
XH = y ( : , 4) ; % Concentración de biomasa no productora
P = y ( : , 5) ; % Concentración de PHA
% Gráfica de l a s concentraciones en función del tiempo
figure
plot ( t , S , ’ LineWidth ’ , 2)
hold on
grid on
grid minor
plot ( t , N, ’ LineWidth ’ , 2)
plot ( t , X , ’ LineWidth ’ , 2)
plot ( t , XH, ’ LineWidth ’ , 2)
plot ( t , P , ’ LineWidth ’ , 2)
xlabel ( ’ t (h) ’ , ’ Interpreter ’ , ’ latex ’ )
ylabel ( ’ Concentración (g/ L ) ’ , ’ Interpreter ’ , ’ latex ’ )
legend ( ’ Sustrato ’ , ’ Nitrógeno ’ , ’ Biomasa productora ’ , ’ Biomasa no productora ’ , ’PHA ’ , ’
interpreter ’ , ’ latex ’ )
set ( gca , ’ fontsize ’ , 1 4 )
