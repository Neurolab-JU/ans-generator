%----------------%
% Fish Generator %
%----------------%
% Version:
%
%   3.1
%
% Author:
%
%   Michael Tesar
%
% Licensing:
%
%   This code is distributed under the GNU LGPL license.

close all; clear all

% Constants
%----------
%
% RATIO HELP: 1, 1.03, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2

coord = fibonacci (100,10,[0,0]); % compute Fibonacci coordinates
scale = 1700;   % scale of grid
x = coord (1,:) * scale;    % extract x coordinates
y = coord (2,:) * scale;    % extract y coordinates

% SET VALUE OF EXEMPLARS
%---------------------------------------------------
exemplars = 10; % number of exemplars in one session
%---------------------------------------------------

% SET VALUE OF RATIO
%---------------------------------------------------
ratio = 1.1;    % set desired ratio
%---------------------------------------------------
numBlue = round(100/(ratio + 1));   % compute number of blue fishes by set ratio
numRed = 100 - numBlue; % compute number of red fishes by set ratio

shuff = 700;    % ratio of shuffling - how fishes is randomized in grid

% generating stimuli
%-------------------
%
for stimuli = 1:exemplars
    
% ones = blue, zeros = red
col = zeros (1,100); col (randperm(numel(col), numBlue)) = 1;   % get random number of blue and red fishes by ratio

load res/stims.mat % load matrix containing images of fishes (blue2 and red2)

% generate red fishes
%--------------------
%
stim = figure ();

for fish = 1:length (coord (1,:))
    hold all
    % asign specifed number of red and blue fish
    if col (fish) == 1
        image (x (fish) + randi ([-shuff shuff]), y (fish) + randi ([-shuff shuff]), blue2)
    else
        image (x (fish) + randi ([-shuff shuff]), y (fish) + randi ([-shuff shuff]), red2)
    end
end

% modify of figure
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axis off

% custom name of export
if ratio == 1
    name = sprintf ('%.2f_B%d_R%d_%d_same.jpg',ratio, numBlue, numRed, stimuli);
else
    name = sprintf ('%.2f_B%d_R%d_%d_red.jpg',ratio, numBlue, numRed, stimuli);
end

% save figure
print(stim, '-djpeg', '-r400',name)
close all
end

% generate blue fishes
%---------------------
%
for stimuli = 1:exemplars
    
for fish = 1:length (coord (1,:))
    hold all
    % asign specifed number of red and blue fish
    if col (fish) == 1
        image (x (fish) + randi ([-shuff shuff]), y (fish) + randi ([-shuff shuff]), red2)
    else
        image (x (fish) + randi ([-shuff shuff]), y (fish) + randi ([-shuff shuff]), blue2)
    end
end

% modify of figure
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axis off

% custom name of export
if ratio == 1
    name = sprintf ('%.2f_B%d_R%d_%d_same.jpg',ratio, numBlue, numRed, stimuli);
else
    name = sprintf ('%.2f_B%d_R%d_%d_blue.jpg',ratio, numBlue, numRed, stimuli);
end

% save figure
print(stim, '-djpeg', '-r400', name)
close all
end