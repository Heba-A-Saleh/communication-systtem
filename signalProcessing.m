close all
clear all

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

%% %Step
unitstep = zeros(size(t)); 
unitstep2 = zeros(size(t)); 
t1 = (-2:L-1)*T;
unitstep(t1>=0) = 1; 
subplot(3,2,1)
plot(1000*t1(1:51),unitstep(1:51))
title('Unit Step Function')
xlabel('t (milliseconds)')
ylabel('Amplitude')

Y = fft(unitstep);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3,2,2)
f = Fs*(0:(L/2))/L;
stem(f,P1, 'x') 
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')

%% %Impulse
Impulse = t1==0;
subplot(3,2,3)
plot(1000*t1(1:51),Impulse(1:51))
title('Impulse Function')
xlabel('t (milliseconds)')
ylabel('Amplitude')

Y = fft(Impulse);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3,2,4)
f = Fs*(0:(L/2))/L;
stem(f,P1, 'x') 
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')

%% %Ramp
Ramp = (t);

subplot(3,2,5)
plot(1000*t(1:50),Ramp(1:50))
title('Ramp Function')
xlabel('t (milliseconds)')
ylabel('Amplitude')


Y = fft(Ramp);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3,2,6)
f = Fs*(0:(L/2))/L;
stem(f,P1, 'x') 
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')


%% %Exponential

Exponential = exp(-t/0.5e-2);

subplot(2,2,1)
plot(1000*t(1:50),Exponential(1:50))
title('Exponential Function')
xlabel('t (milliseconds)')
ylabel('Amplitude')


Y = fft(Exponential);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,2,2)
f = Fs*(0:(L/2))/L;
stem(f,P1, 'x') 
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')

%% %Sin
S = 1*sin(2*pi*50*t);
subplot(2,2,3)
plot(1000*t(1:50),S(1:50))
title('Sinusoidal Function')
xlabel('t (milliseconds)')
ylabel('Amplitude')

Y = fft(S);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,2,4)
f = Fs*(0:(L/2))/L;
stem(f,P1, 'x') 
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')
