function E = efun (O, J )
% Esta función calcula e l error E entre los datos observados (O) y los valores simulados (
J ) .
E1 = sum( (O − J ) . ^ 2 ) ; % Suma de los errores a l cuadrado
E2 = sum( (O − mean(O) ) . ^ 2 ) ; % Variación t o t a l de los datos observados
E = 1 − ( E1 / E2 ) ; % Cálculo de E
end
