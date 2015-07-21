1; #I'm a script

function z = naive_hill (x, y)
  [xx, yy] = meshgrid (x, y);
  r = xx.^2 + yy.^2;
  z = 2*exp(-r.*.1) .+ exp(-r.*.1).*( sin(2*x)  *  cos(y') );
endfunction

function visualize (f)
  ty = tx = linspace(-10, 10, 257)';
  tz = f(tx, ty)
  mesh(tx, ty, tz);
endfunction

%visualize(naive_hill)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ef = @(x,y) sin(2*x)  *  cos(y');

smooth_cutoff = @(f) @(x,y) exp(-(repmat(x, length(y), 1).^2 + repmat(y', 1, length(x)).^2).*.1).*f(x,y);

%visualize(smooth_cutoff (ef)) %(broken - whyever)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = randn(6);

subplot( 1, 2, 1 )
mesh( 8*interp2( A, 5, "cubic" ) );
axis off equal

subplot( 1, 2, 2 )
surf( A )
axis off equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close

function [x, y] = noise(frequency, amplitude, resolution)
  tx = linspace(-1, 1, 2*frequency + 1);
  ty = amplitude*randn(1, 2*frequency + 1);
  x = linspace(-1, 1, 2*resolution);
  y = spline(tx, ty, x);
endfunction
