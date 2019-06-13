clear all;
S=0;
V=0;
a=0;
h=0.1;
sim_time = 100;
S_log = zeros(sim_time / h,1);
V_log = zeros(sim_time / h,1);
W_log = zeros(sim_time / h,1);
Ft_log = zeros(sim_time / h,1);
Fr_log = zeros(sim_time / h,1);
Gr_log = zeros(sim_time / h,1);
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
     it = it + 1;
     S = S + V*h;
     V = V + a*h;

     wheel_speed = 60* V/(2*pi*effective_wheel_radius); %In RPM
     engine_speed = max(wheel_speed * getReductionRatio(gear), 1000);    
     
     if (shiftingUp > 0)
         tractive_force = 0;
         shiftingUp = shiftingUp - 1; 
         Gr_log(it) = 0;
     elseif (engine_speed > shiftUp_speed && gear < maxGear)
         shiftingUp = shiftUp_time;
         gear = gear + 1;
         tractive_force = 0;
         Gr_log(it) = 0;
     else
         tractive_force = min(getThrust(engine_speed, gear),getMaxThrust(a));
         Gr_log(it) = gear;
     end
     
     resistant_force = getResitance(V);
     
     total_F = tractive_force - resistant_force;
     
     a = total_F / total_mass;    
     V_log(it)=3.6 * V; 
     S_log(it) = S;
     W_log(it) = engine_speed;
     Ft_log(it) = tractive_force;
     Fr_log(it) = resistant_force;
     
end
disp("End of Simulation");
figure;
suptitle({"Aceleração BMW M3 E30 1985", " ", " "}  );
subplot(2,2,1);
plot(timespan, V_log);
title("Velocidade");
xlabel("Tempo [s]");
ylabel("Velocidade [km/h]");

subplot(2,2,2);
plot(timespan, W_log);
title("Velocidade do Motor");
xlabel("Tempo [s]");
ylabel("Rotação [RPM]");
ylim([0 8000]);

subplot(2,2,3);
plot(timespan, Ft_log,"blue", timespan, Fr_log, "red");
title("Balanço de forças");
xlabel("Tempo [s]");
ylabel("Força [N]");
legend({"Força trativa","Força resistiva"});

subplot(2,2,4);
plot(timespan, Gr_log);
title("Troca de Marchas");
xlabel("Tempo [s]");
ylabel("Marcha");
ylim([0 5.9]);

Assetto_corsa_run;


