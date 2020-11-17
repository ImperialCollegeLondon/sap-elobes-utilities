function[out] = fade_in_out(in,fs,fade_duration)

if nargin < 2 || isempty(fs)
    fs = 1;
end
if nargin < 3 || isempty(fade_duration)
    fade_duration = 0.03;
end

fade_len = round(fade_duration*fs);

[nsamples, nchans] = size(in);

if nsamples < fade_len
    error('Need to make signal longer or fade shorter!')
end

win = ones(nsamples,1);
win(1:fade_len) = cos_fade_in(fade_len);
win(end-fade_len+[1:fade_len]) = cos_fade_out(fade_len) .* win(end-fade_len+[1:fade_len]);
win = repmat(win,1,nchans);

out = win.*in;


function[win] = cos_fade_in(n)
%defines a rising cosine window
win = (1-cos([1:n]'/(n+1)*pi))/2;

function[win] = cos_fade_out(n)
%defines a falling cosine window
win = (1+cos([1:n]'/(n+1)*pi))/2;