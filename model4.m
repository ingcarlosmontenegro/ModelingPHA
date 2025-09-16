function dydt = odefcnPHA4( t , y , V , F1 , F2 , umax, a1 , a2 , a3 , Ks , Kn, Sm, Nm, Pm, SF , Yxs ,
ms, NF, mn, a l f , CN, d , b)
% Esta función calcula l a tasa de cambio de l a s variables de estado en un sistema de
ecuaciones diferenciales ordinarias (ODE) .
% Parámetros :
% t : tiempo ( variable independiente )
% y : vector de estado que contiene l a s variables dependientes
% V : volumen del reactor
% F1 , F2 : f l u j o s de entrada de sustrato
% umax: velocidad máxima de crecimiento
% a1 , a2 , a3 : exponentes de inhibición
% Ks , Kn : constantes de saturación de sustrato y nitrógeno
% Sm, Nm, Pm: umbrales de sustrato , nitrógeno y producto
% SF : concentración de sustrato en l a solución de alimentación
% Yxs : rendimiento de biomasa respecto a l sustrato
% ms, mn: tasas de mantenimiento de biomasa y nitrógeno
% NF : concentración de nitrógeno en l a solución de alimentación
% a l f : coeficiente de inhibición
% CN: concentración de nitrógeno
% d , b : parámetros para e l rendimiento de biomasa respecto a l nitrógeno
% Calcular l a tasa de dilución del reactor
D = ( F1 + F2 ) / V ;
% Calcular l a tasa de crecimiento microbiano ( velocidad específica )
u = umax * ( y ( 2 ) / ( Ks + y ( 2 ) ) ) * ( y ( 3 ) / (Kn + y ( 3 ) ) ) * . . .
( 1 − ( ( y ( 2 ) / Sm) ^ a1 ) ) * ( 1 − ( ( y ( 3 ) / Nm) ^ a2 ) ) * ( 1 − ( ( y ( 1 ) / Pm) ^ a3 ) ) ;
% Calcular e l rendimiento de biomasa respecto a l nitrógeno
Yxn = (d * CN) / (b + CN) ;
% I n i c i a l i z a r e l vector de salida para l a s tasas de cambio de l a s variables de estado
dydt = zeros ( 4 , 1 ) ;
% Definir l a s ecuaciones diferenciales
dydt ( 1 ) = u * y ( 1 ) ; % Cambio en l a biomasa
dydt ( 2 ) = − ( ( (u / Yxs ) + ms) * y ( 1 ) ) ; % Cambio en e l sustrato
dydt ( 3 ) = − ( ( (u / Yxn ) + mn) * y ( 1 ) ) ; % Cambio en e l nitrógeno
dydt ( 4 ) = ( a l f * u) * y ( 1 ) ; % Cambio en e l producto
