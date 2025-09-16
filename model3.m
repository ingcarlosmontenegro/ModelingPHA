clear % Borra todas l a s variables del área de trabajo
close a l l % Cierra todas l a s figuras abiertas anteriormente
load MSData .mat % Carga los datos experimentales desde un archivo MAT
time = 0 : 1 2 : 7 2 ; % Vector de tiempo para l a simulación (0 a 72 horas con pasos de
12 horas )
% Condiciones i n i c i a l e s para l a biomasa y e l PHA
DB0 = 0 . 0 5 ; % Concentración i n i c i a l de biomasa (g/ L )
DPHA0 = 0 . 0 3 ; % Concentración i n i c i a l de PHA (g/ L )
NumC = 1 ; % Número de combinación
% Obtener los datos experimentales para biomasa (DB) y PHA (DPHA)
DB = [ DataBiomasa ( 2 : end , NumC+ 1 ) ; DataBiomasa (end , NumC+ 1 ) ] ; % Datos experimentales para
biomasa
DPHA = [DataPHA ( 2 : end , NumC+ 1 ) ; DataPHA(end , NumC+ 1 ) ] ; % Datos experimentales para PHA
data = [DB DPHA] ; % Matriz que contiene los datos de biomasa y PHA
opts = statset ( ’ n l i n f i t ’ ) ; % Opciones para e l ajuste no l i n e a l
options = optimoptions ( ’ lsqnonlin ’ , ’ Display ’ , ’ i t e r −detailed ’ , ’ MaxIterations ’ , 100 , ’
StepTolerance ’ , 1 e−6 , ” DiffMinChange ” , 0 . 1 , ’ FunctionTolerance ’ , 1 e − 1 2 , ’
OptimalityTolerance ’ , 1 e − 1 2 ) ; % Opciones para lsqnonlin
parguess = [5 0 . 1 0.2 5 10 1 ] ; % Suposiciones i n i c i a l e s para los parámetros del modelo
% Ajuste de los parámetros del modelo a los datos experimentales utilizando lsqnonlin
x = lsqnonlin (@func , parguess , [0.001 0.001 0.001 0.001 0.001 0 . 0 0 1 ] , [ 1 0 10 10 10 10 1 0 ] ,
options ) ;
% Generar una serie de tiempo para l a simulación
t f i t = linspace ( 0 , 72) ;
% Calcular los valores simulados utilizando los parámetros ajustados
f i t = func ( x ) ;
% Graficar los resultados experimentales y simulados
figure
plot ( time , f i t ( : , 1 ) ) % Biomasa simulada
hold on
plot ( time , DB, ” ^ ” , ’ LineWidth ’ , 2) % Biomasa experimental
plot ( time , f i t ( : , 2) ) % PHA simulado
plot ( time , DPHA, ” square ” , ’ LineWidth ’ , 2) % PHA experimental
function out = func ( pars )
% Esta función calcula los valores simulados utilizando e l modelo y los parámetros dados .
% Definir l a s condiciones i n i c i a l e s y parámetros del modelo
So = 1 ; % Concentración i n i c i a l de sustrato (g/ L )
No = 2 . 5 ; % Concentración i n i c i a l de nitrógeno (g/ L )
Xo = 0 . 0 5 ; % Concentración i n i c i a l de biomasa (g/ L )
Xho = 0 ; % Concentración i n i c i a l de biomasa no productora (g/ L )
Po = 0 . 0 3 ; % Concentración i n i c i a l de PHA (g/ L )
V = 1 0 ; % Volumen del reactor ( L )
FN = 0 ; % Flujo de nitrógeno (g/h)
FS = 0 ; % Flujo de sustrato (g/h)
F = FS + FN ; % Flujo t o t a l (g/h)
D = F /V ; % Tasa de dilución ( 1 / h)
SF = 0 ; % Concentración de acetato en l a solución de alimentación (g/ L )
NF = 0 ; % Concentración de nitrógeno de amonio en l a solución de
alimentación (g/ L )
uxsmax = 0.059; % Velocidad máxima de crecimiento específico de biomasa (g célula /
g célula /h)
uxhsmax = 0.040; % Velocidad máxima de crecimiento específico de biomasa PHA (g
célula /g célula /h)
uprodmax = pars ( 1 ) ; % Velocidad máxima de producción de PHA (g PHA/g célula /h)
uxphamax = pars ( 2 ) ; % Velocidad máxima de consumo de PHA (g célula /g célula /h)
Kxs = 0 . 2 1 3 ; % Constante de saturación de sustrato para e l crecimiento de
biomasa (g acetato / L )
Kn = 0.254; % Constante de saturación de nitrógeno (g N/ L )
Kxhs = 0 . 2 1 3 ; % Constante de saturación de sustrato para e l crecimiento de
biomasa PHA (g acetato / L )
Knh = 0.254; % Constante de saturación de nitrógeno para e l crecimiento de
biomasa PHA (g N/ L )
Kps = 0 . 2 1 3 ; % Constante de saturación de sustrato para l a producción de PHA (g
acetato / L )
Kpin = pars ( 3 ) ; % Constante de saturación de nitrógeno para l a producción de PHA (
g N/ L )
Kxpha = 0.00009; % Constante de saturación de PHA para e l crecimiento de biomasa (g
PHA/g célula )
Kis = pars ( 4 ) ; % Constante de inhibición de sustrato (g/ L )
yxs = 0 . 1 8 ; % Rendimiento en biomasa respecto a l sustrato (g célula /g acetato )
yxhs = 1 . 3 7 ; % Rendimiento en biomasa PHA respecto a l sustrato (g célula PHA/g
acetato )
yps = 1 . 3 7 ; % Rendimiento en PHA respecto a l sustrato (g PHA/g acetato )
yxn = 2 . 9 7 ; % Rendimiento en biomasa respecto a l nitrógeno (g célula /g N)
yxp = 0 . 8 1 ; % Rendimiento en PHA respecto a l a biomasa (g PHA/g célula )
yatps = 8 . 4 5 ; % Rendimiento en ATP respecto a l sustrato (g ATP/g acetato )
yatppha = 1 3 . 0 9 ; % Rendimiento en ATP respecto a l PHA (g ATP/g PHA)
Sm = pars ( 5 ) ; % Valor umbral de sustrato para e l crecimiento de biomasa (g/ L )
C = pars ( 6 ) ; % Parámetro de corrección del modelo
fphamax = 2 . 4 7 ; % Velocidad máxima de producción de PHA (g PHA/g célula )
a l f = 3 . 8 5 ; % Coeficiente de inhibición de PHA
matp = 0 . 1 1 0 5 ; % Rendimiento en ATP respecto a l a biomasa (g ATP/g célula /h)
y0 = [ So No Xo Xho Po ] ; % Condiciones i n i c i a l e s del sistema
Ts = 0 . 1 ; % Paso de tiempo para l a integración
options_sim = odeset ( ’MaxStep ’ , Ts ) ; % Opciones para l a integración numérica
% Resolver e l sistema de ecuaciones diferenciales utilizando ode45
[ t , y ] = ode45 (@( t , y ) odefcnPHA2 ( t , y , V , FS , FN, SF , NF, uxsmax , uxhsmax , uprodmax,
uxphamax, Kxs , Kn, Kxhs , Knh, Kps , Kpin , Kxpha , Kis , yxs , yxhs , yps , yxn , yxp , yatps ,
yatppha , Sm, C , fphamax , a l f , matp) , t 1 , y0 , options_sim ) ;
% Buscar los índices correspondientes a los tiempos específicos en e l vector t
indices_tiempo_especifico = zeros ( length ( t 1 ) , 1 ) ;
f o r i = 1 : length ( t 1 )
[ ~ , idx ] = min( abs ( t − t 1 ( i ) ) ) ;
indices_tiempo_especifico ( i ) = idx ;
end
% Extraer los valores de biomasa y PHA simulados para los tiempos específicos
out ( : , 2) = abs ( y ( indices_tiempo_especifico , 3) ) ; % Biomasa simulada
out ( : , 1 ) = abs ( y ( indices_tiempo_especifico , 5) ) ; % PHA simulado
out ( isnan ( out ) ) = 0 ; % Reemplazar NaN por 0
out ( i s i n f ( out ) ) = 10000; % Reemplazar I n f por 10000
end
