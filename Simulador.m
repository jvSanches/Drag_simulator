clear all;
S=0;  %Posi��o
V=0;  %Velocidade
a=0;  %Acelera��o
h=0.1;%Passo
sim_time = 100; %tempo de simula��o

%Lista de resultados
S_log = zeros(sim_time / h,1);
V_log = zeros(sim_time / h,1);
W_log = zeros(sim_time / h,1);
Ft_log = zeros(sim_time / h,1);
Fr_log = zeros(sim_time / h,1);
Gr_log = zeros(sim_time / h,1);
Mf_log = zeros(sim_time / h,1);

%Par�metros
total_mass = 1275;
effective_wheel_radius = 0.285;
gear = 1;
maxGear = 5;
shiftUp_time = 0.5 / h;
shiftUp_speed = 7200;
it = 0;
timespan = 0:h:sim_time;
shiftingUp = 0;

disp("Starting Run");
for t = timespan
    %Itera��o de Euler
     it = it + 1;
     S = S + V*h;
     V = V + a*h;
     %Calculo da velocidade de rota��o do motor
     wheel_speed = 60* V/(2*pi*effective_wheel_radius); %In RPM
     engine_speed = max(wheel_speed * getReductionRatio(gear), 1000);   
     
     maxThrust = getMaxThrust(a);
     Mf_log(it) = maxThrust;
     %Sele��o e troca de marchas
     if (shiftingUp > 0)
         %Durante troca de marchas
         %Transmiss�o desacoplada
         tractive_force = 0;
         shiftingUp = shiftingUp - 1; 
         Gr_log(it) = 0;
     elseif (engine_speed > shiftUp_speed && gear < maxGear)
         %Inicio da troca de marchas
         shiftingUp = shiftUp_time;
         gear = gear + 1;
         tractive_force = 0;
         Gr_log(it) = 0;
     else
         %Marcha engatada
         %Calculo da m�xima for�a devido ao atrito e efeitos de
         %tranfer�ncia de peso
         %Calculo da for�a produzida pelo motor
        
         tractive_force = min(getThrust(engine_speed, gear), maxThrust);
         Gr_log(it) = gear;
     end
     
     %Calculo da for�a resistiva
     resistant_force = getResitance(V);
     %Calculo da resultante de for�as
     total_F = tractive_force - resistant_force;
     
     %Acelera��o instant�nea
     a = total_F / total_mass;    
     
     %Armazenamento de resultados da itera��o
     V_log(it)=3.6 * V; 
     S_log(it) = S;
     W_log(it) = engine_speed;
     Ft_log(it) = tractive_force;
     Fr_log(it) = resistant_force;
     
end

%Exibi��o dos resultados
disp("End of Simulation");
figure;
suptitle({"Acelera��o BMW M3 E30 1985", " ", " "}  );
subplot(2,2,1);
plot(timespan, V_log);
title("Velocidade");
xlabel("Tempo [s]");
ylabel("Velocidade [km/h]");

subplot(2,2,2);
plot(timespan, W_log);
title("Velocidade do Motor");
xlabel("Tempo [s]");
ylabel("Rota��o [RPM]");
ylim([0 8000]);

subplot(2,2,3);
plot(timespan, Ft_log,"blue", timespan, Fr_log, "red", timespan, Mf_log, "yellow");
title("Balan�o de for�as");
xlabel("Tempo [s]");
ylabel("For�a [N]");
legend({"For�a trativa","For�a resistiva", "M�xima for�a trativa"});

subplot(2,2,4);
plot(timespan, Gr_log);
title("Troca de Marchas");
xlabel("Tempo [s]");
ylabel("Marcha");
ylim([0 5.9]);

%Script auxiliar para gera��o da curva de compara��o
%com simulador comercial
Assetto_corsa_run;


