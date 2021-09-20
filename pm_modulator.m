function u = pm_modulator(m,t,Ac,fc,kp)

u = Ac*cos(2*pi*fc*t+kp*m);

end

