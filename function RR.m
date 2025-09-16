function RR = Rfun (O, J )
% Esta función calcula e l coeficiente de determinación R^2 entre los datos observados (O)
y los valores simulados ( J ) .
R1 = sum( (O − mean(O) ) . * ( J − mean( J ) ) ) ; % Numerador de l a ecuación de R^2
R2 = sqrt (sum( (O − mean(O) ) . ^ 2 ) ) * sqrt (sum( ( J − mean( J ) ) . ^ 2 ) ) ; % Denominador de l a
ecuación de R^2
RR = ( R1 / R2) ^ 2 ; % Cálculo de R^2
end
