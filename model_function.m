function dydt = odefcnPHA( t , y , V , FS , FN, SF , NF, uxsmax , uxhsmax , uprodmax, uxphamax, Kxs ,
Kn, Kxhs , Knh, Kps , Kpin , Kxpha , Kis , yxs , yxhs , yps , yxn , yxp , yatps , yatppha , Sm, C ,
fphamax , a l f , matp)
% Esta función calcula l a s tasas de cambio de diferentes especies en un proceso
biotecnológico modelado mediante ecuaciones diferenciales ordinarias (ODE) .
% Parámetros del modelo :
% Volumen del reactor
% FS : Flujo de sustrato (g/h)
% FN : Flujo de nitrógeno (g/h)
% SF : Relación sustrato / célula
% NF : Relación nitrógeno / célula
% Parámetros cinéticos y de rendimiento :
% uxsmax : Velocidad máxima de crecimiento específico de biomasa (g célula /g célula /h)
% uxhsmax : Velocidad máxima de crecimiento específico de biomasa PHA (g célula /g célula /h)
% uprodmax : Velocidad máxima de producción de PHA (g PHA/g célula /h)
% uxphamax : Velocidad máxima de consumo de PHA (g célula /g célula /h)
% Kxs : Constante de saturación de sustrato para e l crecimiento de biomasa (g acetato / L )
% Kn : Constante de saturación de nitrógeno (g N/ L )
% Kxhs : Constante de saturación de sustrato para e l crecimiento de biomasa PHA (g acetato /
L )
% Kps : Constante de saturación de sustrato para l a producción de PHA (g acetato / L )
% Kpin : Constante de saturación de nitrógeno para l a producción de PHA (g N/ L )
% Kxpha : Constante de saturación de PHA para e l crecimiento de biomasa (g PHA/g célula )
% Kis : Constante de inhibición de sustrato (g/ L )
% Rendimientos :
% yxs : Rendimiento en biomasa respecto a l sustrato (g célula /g acetato )
% yxhs : Rendimiento en biomasa PHA respecto a l sustrato (g célula /g acetato )
% yps : Rendimiento en PHA respecto a l sustrato (g PHA/g acetato )
% yxn : Rendimiento en biomasa respecto a l nitrógeno (g célula /g N)
% yxp : Rendimiento en biomasa respecto a l PHA (g célula /g PHA)
% yatps : Rendimiento en ATP respecto a l sustrato (g ATP/g acetato )
% yatppha : Rendimiento en ATP respecto a l PHA (g ATP/g PHA)
% Otros parámetros :
% Sm: Concentración de sustrato (g/ L )
% C : Coeficiente adimensional
% fphamax : Fracción máxima de PHA en células (g PHA/g célula )
% a l f : Coeficiente adimensional
% matp : Masa de ATP (g ATP/g célula /h)
% Cálculo de l a velocidad de dilución (D)
D = ( FS + FN) / V ;
% Cálculo de l a s tasas de crecimiento específicas
uxs = (uxsmax * ( 1 − ( y ( 1 ) / Sm) ) ^C) * ( y ( 1 ) / ( y ( 1 ) + Kxs ) ) * ( y ( 2 ) / ( y ( 2 ) + Kn) ) ;
fpha = ( y ( 5 ) / y ( 3 ) ) ;
uprod = uprodmax * ( ( 1 − ( y ( 1 ) / Sm) ) ^C) * ( y ( 1 ) / ( y ( 1 ) + Kps ) ) * ( 1 − ( ( fpha / fphamax) ^
a l f ) ) * ( Kpin / ( y ( 2 ) + Kpin ) ) ;
uxpha = uxphamax * ( fpha / (Kxpha + fpha ) ) * ( y ( 2 ) / ( y ( 2 ) + Kn) ) * ( Kis / ( y ( 1 ) + Kis ) ) ;
msx = (matp / yatps ) * ( y ( 1 ) / ( y ( 1 ) + Kxs ) ) ;
mpha = (matp / yatppha ) * ( fpha / (Kxpha + fpha ) ) * ( Kis / ( y ( 1 ) + Kis ) ) ;
ex = (matp / yatps ) * yxs * ( 1 − ( y ( 1 ) / ( y ( 1 ) + Kxs ) ) ) * ( 1 − ( fpha / (Kxpha + fpha ) ) ) ;
uxhs = uxhsmax * ( y ( 1 ) / ( y ( 1 ) + Kxhs ) ) * ( y ( 2 ) / ( y ( 2 ) + Knh) ) ;
msxh = (matp / yatps ) * ( y ( 1 ) / ( y ( 1 ) + Kxhs ) ) ;
exh = (matp / yatps ) * yxs * ( 1 − ( y ( 1 ) / ( y ( 1 ) + Kxs ) ) ) ;
% I n i c i a l i z a c i ó n del vector de derivadas
dydt = zeros ( 5 , 1 ) ;
% Ecuaciones diferenciales
dydt ( 1 ) = ( ( FS * SF ) / V) − (D * y ( 1 ) ) − ( ( uxs / yxs ) * y ( 3 ) ) − ( ( uxhs / yxhs ) * y ( 4 ) ) −
( ( uprod / yps ) * y ( 3 ) ) − (msx * y ( 3 ) ) − (msxh * y ( 4 ) ) ;
dydt ( 2 ) = ( (FN * NF) / V) − (D * y ( 2 ) ) − ( ( ( uxs + uxpha ) / yxn ) * y ( 3 ) ) − ( ( uxhs / yxn ) *
y ( 4 ) ) ;
dydt ( 3 ) = ( ( uxs + uxpha ) * y ( 3 ) ) − (D * y ( 3 ) ) − ( ex * y ( 3 ) ) ;
dydt ( 4 ) = ( uxhs * y ( 4 ) ) − (D * y ( 4 ) ) − ( exh * y ( 4 ) ) ;
dydt ( 5 ) = ( uprod − ( uxpha / yxp ) ) * y ( 3 ) − (D * y ( 5 ) ) − (mpha * y ( 4 ) ) ;
end
