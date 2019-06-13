Logging_time = [38 39 40 41 42 43 44 45 46 47 50 55 60 65 70 80 90 100 120 138];
t_ref = Logging_time - Logging_time(1);
v_ref = [0 17 35 52 68 80 94 104 111 120 143 165 186 203 210 224 233 240 248 251];
S_ref = zeros(length(v_ref),1);
for i = 2:length(v_ref)
    S_ref(i) = S_ref(i-1) + v_ref(i)/3.6*(t_ref(i)-t_ref(i-1));
end

figure;
suptitle({"Aceleração BMW M3 E30 1985", " ", " "}  );
plot(t_ref, v_ref);
title("Comparação com o simulador Assetto Corsa");
xlabel("Tempo [s]");
ylabel("Velocidade [km/h]");
hold on;
plot(timespan, V_log);
legend({"Assetto Corsa","Simulação MATLAB"});

figure;
suptitle({"Aceleração BMW M3 E30 1985", " ", " "}  );
plot(t_ref, S_ref);
title("Comparação com o simulador Assetto Corsa");
xlabel("Tempo [s]");
ylabel("Posição [m]");
hold on;
plot(timespan, S_log);
legend({"Assetto Corsa","Simulação MATLAB"});
