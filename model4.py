import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import math
# Definición de la función de ecuaciones diferenciales
def odefcnPHA5(y, t, V, F1, F2, umax , a1, a2, a3, Ks, Kn, Sm,
Nm, Pm, SF, Yxs, ms, NF, mn, alf, d, b, CN):
    X, S, N, P = y
    # Cálculo de la tasa de dilución
    D = (F1 + F2) / V
    # Cálculo de la relación de rendimiento de biomasa respecto
    al nitrógeno
    Yxn = (d * CN) / (b + CN)
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
# Definición de datos experimentales
t1 = np.array([0, 6, 18, 24, 31, 43, 48, 54, 66, 72])
XR = np.array([2.1, 2.51, 3.49, 3.80, 5.02, 6.52, 6.67, 6.70,
6.65, 5.42])
PR = np.array([1.2, 1.54, 2.57, 2.26, 3.39, 4.05, 4.97, 5.25,
4.80, 3.50])
SR = np.array([5.00, 4.13, 2.00, 1.08, 1.08, 0.00, 0.00, 0.00,
0.00, 0.00])
NR = np.array([2.41, 2.36, 2.08, 1.69, 1.03, 0.84, 0.44, 0.13,
0.12, 0.16])
# Condiciones iniciales
Xo = 2.1
So = 5.0
No = 2.41
Po = 1.2
y0 = np.array([Xo, So, No, Po])
# Vector de tiempo
t = np.linspace(0, 72, 1000)
# Parámetros del sistema
V = 1
F1 = 0
F2 = 0
umax = 0.07
a1 = 2.6
a2 = 10.23
a3 = 1.163
Ks = 3.35
Kn = 0.036
Sm = 191.32
Nm = 15.47
Pm = 14.62
SF = 0
Yxs = 0.89
ms = 0.0016
NF = 0
mn = 0.0015
alf = 0.92
d = 9.32
b = 0.1314
CN = 7
# Resolver la ecuación diferencial
sol = odeint(odefcnPHA5 , y0, t, args=(V, F1, F2, umax , a1, a2,
a3, Ks, Kn, Sm, Nm, Pm, SF, Yxs, ms, NF, mn, alf, d, b, CN),
atol=1e 1 2 , rtol=1e 1 2 )
# Graficar los resultados
plt.figure(1)
plt.plot(t, sol[:, 0], ’b ’, linewidth=2)
plt.plot(t1, XR, "^", linewidth=2)
plt.plot(t, sol[:, 1], ’g ’, linewidth=2)
plt.plot(t1, SR, "s", linewidth=2)
plt.plot(t, sol[:, 2], ’r ’, linewidth=2)
plt.plot(t1, NR, "^", linewidth=2)
plt.plot(t, sol[:, 3], ’m ’, linewidth=2)
plt.plot(t1, PR, "s", linewidth=2)
plt.xlim([0, 72])
plt.xlabel(r’$t$ (h)’, fontsize=14)
plt.ylabel(’Concentracion (g/L)’, fontsize=14)
plt.legend([’Biomasa sim’, ’Biomasa’, ’Sustrato sim’, ’Sustrato
’, ’Nitrogeno sim’, ’Nitrogeno’, ’PHA sim’, ’PHA’], fontsize
=12)
plt.grid(True)
plt.grid(which=’minor’, linestyle=’:’, linewidth=’0.5’, color=’
black’)
plt.tick_params(labelsize=14)
plt.show()
