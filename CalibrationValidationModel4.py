import numpy as np
from scipy.integrate import odeint
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt
import math
# Definición de la función de ecuaciones diferenciales
def odefcnPHA5(y, t, V, F1, F2, umax , a1, a2, a3, Ks, Kn, Sm,
Nm, Pm, SF, Yxs, ms, NF, mn, alf, Yxn):
    X, S, N, P = y
    # Cálculo de la tasa de dilución
    D = (F1 + F2) / V
    # Cálculo de la tasa de crecimiento específico
    u = (umax * (S / (Ks + S)) * (N / (Kn + N)) * (1 (math.
    pow((abs(S) / abs(Sm)), a1))) * (1 (math.pow((abs(N) /
    abs(Nm)), a2))) * (1 (math.pow((abs(P) / abs(Pm)), a3
    ))))
    # Ecuaciones diferenciales
    dXdt = u * X
    dSdt = ( ( ( u / Yxs) + ms) * X)
    dNdt = ( ( ( u / Yxn) + mn) * X)
    dPdt = ((alf * u) * X)
    return [dXdt , dSdt , dNdt , dPdt]
# Definición de la función que retorna los valores de X y P en tiempos específicos
def func(time , umax , Ks, Kn, Sm, Nm, Pm, a1, a2, a3, Yxs, Yxn,
alf):
    So = 1
    No = 2.5
    Xo = 0.058333333333345
    Po = 0.033333333333333
    ms = 0.0016
    mn = 0.0015
    SF=0
    NF=0
    V = 7
    F1 = 0
    F2 = 0
    y0 = np.array([Xo, So, No, Po])
    t = np.linspace(0, 72, 1000)
    sol = odeint(odefcnPHA5 , y0, t, args=(V, F1, F2, umax , a1,
    a2, a3, Ks, Kn, Sm, Nm, Pm, SF, Yxs, ms, NF, mn, Yxn,
    alf), atol=1e 1 2 , rtol=1e 1 2 )
    # Encontrar los índices correspondientes a los tiempos específicos en el vector t
    indices_tiempo_especifico = np.zeros((len(time),), dtype=
    int)
    for i in range(len(time)):
    idx = np.argmin(np.abs(t time[i]))
    indices_tiempo_especifico[i] = idx
    # Extraer los valores de X y P en los tiempos específicos
    out = np.zeros((len(indices_tiempo_especifico), 2))
    out[:, 0] = np.real(sol[indices_tiempo_especifico , 0])
    out[:, 1] = np.real(sol[indices_tiempo_especifico , 3])
    # Reemplazar NaN por 0 e Inf por 10000
    out[np.isnan(out)] = 0
    out[np.isinf(out)] = 10000
    sal = np.append(out[:, 0], out[:, 1])
    return sal

# Definición de la función que retorna los valores de X y P en tiempos específicos (otra versión)
def func2(time , umax , Ks, Kn, Sm, Nm, Pm, a1, a2, a3, Yxs, Yxn,
alf):
    So = 1
    No = 2.5
    Xo = 0.058333333333345
    Po = 0.033333333333333
    ms = 0.0016
    mn = 0.0015
    SF=0
    NF=0
    V = 7
    F1 = 0
    F2 = 0
    y0 = np.array([Xo, So, No, Po])
    t = time
    sol = odeint(odefcnPHA5 , y0, t, args=(V, F1, F2, umax , a1,
    a2, a3, Ks, Kn, Sm, Nm, Pm, SF, Yxs, ms, NF, mn, Yxn,
    alf), atol=1e 1 2 , rtol=1e 1 2 )
    return sol
# Datos experimentales
time = np.array([12,24,36,48,60,72])
DB = np.array
([0.058333333333345 ,0.300000000000041 ,0.416666666666732 ,0.499999999999871 DPHA = np.array
([0.033333333333333 ,0.283333333333333 ,0.370000000000000 ,0.450000000000000
data = np.array([DB, DPHA])
data2 = np.append(DB, DPHA)
# Ajuste de curva a la función ’func’ usando curve_fit
popt , pcov = curve_fit(func , time , data2 , bounds=(0.001,(0.47,
100, 100, 200, 200, 200, 100, 100, 100, 100, 10, 10)))
# Imprimir los parámetros óptimos
print(popt)
print(len(popt))
# Generar datos de ajuste para graficar
tfit = np.linspace(0, 72, 1000)
fit = func2(tfit , *popt)
time2 = np.array([0, 12, 24, 36, 48, 60])
# Graficar los resultados
plt.figure(1)
plt.plot(tfit , fit[:, 0], ’b ’, linewidth=2, label=’Biomasa sim
’)
plt.plot(time2 , DB, ’r^’, markersize=8, label=’Biomasa’)
plt.plot(tfit , fit[:, 3], ’g ’, linewidth=2, label=’PHA sim’)
plt.plot(time2 , DPHA , ’ms’, markersize=8, label=’PHA’)
plt.xlim([0, 72])
plt.xlabel(’t (h)’, fontsize=14)
plt.ylabel(’Concentracion (g/L)’, fontsize=14)
plt.legend(fontsize=14)
plt.grid(True)
plt.grid(which=’minor’, linestyle=’:’, linewidth=’0.5’, color=’
gray’)
plt.minorticks_on()
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
# Segunda figura
plt.figure(2)
plt.plot(tfit , fit[:, 0], ’b ’, linewidth=2, label=’Biomasa sim’)
plt.plot(time2 , DB, ’r^’, markersize=8, label=’Biomasa’)
plt.plot(tfit , fit[:, 3], ’g ’, linewidth=2, label=’PHA sim’)
plt.plot(time2 , DPHA , ’ms’, markersize=8, label=’PHA’)
plt.plot(tfit , fit[:, 1], ’c ’, linewidth=2, label=’Sustrato’)
plt.plot(tfit , fit[:, 2], ’y ’, linewidth=2, label=’Nitrogeno’)
plt.xlim([0, 72])
plt.xlabel(’t (h)’, fontsize=14)
plt.ylabel(’Concentracion (g/L)’, fontsize=14)
plt.legend(fontsize=14)
plt.grid(True)
plt.grid(which=’minor’, linestyle=’:’, linewidth=’0.5’, color=’
gray’)
plt.minorticks_on()
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
# Mostrar las figuras
plt.show()
# Calcular los valores de R^2 y coeficiente de determinación
X = np.abs(fit[:, 0])
S = np.abs(fit[:, 1])
N = np.abs(fit[:, 2])
P = np.abs(fit[:, 3])
t = tfit
# Encontrar los índices correspondientes a los tiempos específicos en el vector t
indices_tiempo_especifico = np.zeros(len(time2), dtype=int)
for i in range(len(time2)):
    idx = np.argmin(np.abs(t time2[i]))
    indices_tiempo_especifico[i] = idx
# Extraer los valores de X y P en los tiempos específicos
Xsim = X[indices_tiempo_especifico]
Psim = P[indices_tiempo_especifico]
# Definir funciones para el cálculo de R^2 y coeficiente de determinación
def Rfun(O, J):
    R1 = np.real(np.sum((O np.mean(O)) * (J np.mean(J))))
    R2 = np.real(np.sqrt(np.sum((O np.mean(O))**2)) * np.sqrt
    (np.sum((J np.mean(J))**2)))
    RR = (R1 / R2)**2
    return RR
def dfun(O, J):
    d1 = np.sum((O J)**2)
    d2 = np.sum(np.abs(O np.mean(O))**2)
    dd = 1 (d1 / d2)
    return dd
# Calcular R^2 y coeficiente de determinación para Biomasa y PHA
RB = Rfun(DB, Xsim)
dB = dfun(DB, Xsim)
RP = Rfun(DPHA , Psim)
dP = dfun(DPHA , Psim)
# Imprimir los resultados de R^2 y coeficiente de determinación para Biomasa y PHA
formatted_values1 = " %.3f %.3f %.3f %.3f" % (RB, dB, RP, dP)
print(formatted_values1)
formatted_values = " ".join([" %.2f" % value for value in popt])
print(formatted_values)
