function y=loadspike(fn,n)
% y=LOADSPIKE(fn) loads spikes from given filename into structure y
% with members:
%
%   time    (1xN)  (in seconds)
%   channel (1xN)  (hardware number, see hw2cr.m)
%   height  (1xN)  (in uV)
%   width   (1xN)  (in ms)
%   context (75xN) (in uV)
%   thresh  (1xN)  (in uV)
%
% y=LOADSPIKE(fn,n) only loads the first N spikes.

% loadspike.m: part of meabench, an MEA recording and analysis tool
% Copyright (C) 2000-2002  Daniel Wagenaar (wagenaar@caltech.edu)
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

if nargin<2 | isempty(n)
  n=inf;
end

fid = fopen(fn,'rb');
if (fid<0)
  error('Cannot open the specified file');
end
raw = fread(fid,[82 n],'int16');
fclose(fid);
ti0 = raw(1,:); idx = find(ti0<0); ti0(idx) = ti0(idx)+65536;
ti1 = raw(2,:); idx = find(ti1<0); ti1(idx) = ti1(idx)+65536;
ti2 = raw(3,:); idx = find(ti2<0); ti2(idx) = ti2(idx)+65536;
ti3 = raw(4,:); idx = find(ti3<0); ti3(idx) = ti3(idx)+65536;
y.time = (ti0 + 65536*(ti1 + 65536*(ti2 + 65536*ti3)));
y.channel = raw(5,:);
y.height = raw(6,:);
y.width = raw(7,:);
y.context = raw(8:81,:);
y.thresh = raw(82,:);

range = 683;
auxrange = range * 1.2; % Correction, DW 10/15/2007.
freq = 25.0;

isaux = find(y.channel>=60);
iselc = find(y.channel<60);
y.height(iselc) = y.height(iselc) .* range/2048;
y.thresh(iselc) = y.thresh(iselc) .* range/2048;
y.context(:,iselc) = y.context(:,iselc) .* range/2048;
y.height(isaux) = y.height(isaux) .* auxrange/2048;
y.thresh(isaux) = y.thresh(isaux) .* auxrange/2048;
y.context(:,isaux) = y.context(:,isaux) .* auxrange/2048;

y.time = y.time ./ (freq*1000);
y.width = y.width ./ freq;
