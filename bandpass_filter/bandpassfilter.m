close all
clear all

Fs = 2000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1000;             % Length of signal

t = (0:T:1-T);
x = cos(2*pi*10*t) + cos(2*pi*20*t) + cos(2*pi*50*t);


%part a sampling the signal
figure;
stem(t,x,'x') 
plot(t,x) 
title('Sampling Signal')
xlabel('f (Hz)')
ylabel('x')

%Part b signal in frequency domain giving an impluse signal at the 
%fundamental frequences of the signal

Xf = fft(x);

figure;
f = (0:(Fs-1));
stem(f,Xf/L, 'x')
title('Frequency Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude')
ylim([0,1.5])

%Part c shiftig the signal to bring it closer to the origin

frequency_domain = (-Fs/2:Fs/2-1);
Xf_shift= fftshift(Xf);
figure;
stem(frequency_domain,(Xf_shift/L),'x')
ylim([0,1.5])

%Part d bandpass filter that eliminate all frequency except 20Hz 

Hf_Positive =zeros(1,Fs/2);
Hf_Negative = Hf_Positive;
Hf_Positive(15:25)= Xf_shift(985:995) ;
Hf_Negative(975:985) = Xf_shift(985:995);
Hf =[Hf_Negative Hf_Positive];

complex_value = -500*frequency_domain*i;

Hf = Hf.*exp(complex_value);

figure;
stem(frequency_domain,abs(Hf/L),'x')
ylim([0,1.5])


%Part e present an impulse at frwuency 20 Hz and -20 Hz

Yf = Xf_shift.*Hf;
figure;
plot(frequency_domain,abs(Yf/L^2))
ylim([0,2])


%Part f invert fourier transforme to get back a filtered signal of
%frequency 20Hz

Yt = ifft(Yf);
Yt_shifted= ifftshift(Yt);
Yy = real (Yt_shifted);


figure;
plot(t,abs(Yt_shifted/L))
title('time Domain of x(t)')
xlabel('Time (s)')
xlim([0 0.5])
ylabel('Amplitude')
ylim([-2,2])


