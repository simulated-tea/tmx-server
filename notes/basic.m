2; #I'm a script

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot( 1, 1, 1 )

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
subplot( 1, 1, 1 )

function [x, y] = noise(frequency, amplitude, resolution, generator)
  x = linspace(-1, 1, 2*resolution+1);
  y = zeros(1, 2*resolution+1);
  for i = 1:length(frequency(:))
    tx = linspace(-1, 1, 2*frequency(i) + 1);
    ty = amplitude(i)*generator(2*frequency(i) + 1);
    y += interp1(tx, ty, x, "spline");
  end
end

function maxI = plotNoise(nextFrequency, nextAmplitude, resolution)
  f = [4]; a = [1]; i = 0;
  while 10*f(end) < resolution || i > 40
    f(end+1) = nextFrequency(f(end));
    a(end+1) = nextAmplitude(a(end));
    i++;
  end
  [x, y] = noise(f, a, resolution, @(x) randn(1, x));
  plot(x, y)
  axis equal
  maxI = i;
end

function A = sample(nf, na)
  A = zeros(2, 3);
  for i = 1:6
    subplot(2, 3, i)
    A(i) = plotNoise(nf, na, 512);
  end
end

%plotNoise(@(x) x*2, @(x) x/2, 1024)
%sample(@(x) x*2, @(x) x/2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot( 1, 1, 1 )

%function A = stretch(a, n)
%  m = length(a(:));
%  S1 = eye(m)
%  S2 = sortrows(repmat(S1, n, 1), -1:-m);
%  A = repmat(a, n, n);
%end

function A = stretch(a, n)
  [s, t] = size(a);
  A = zeros(s*n, t*n);
  for i = 1:s
    for j = 1:t
      A(n*(i-1)+1:n*i, n*(j-1)+1:n*j) = a(i, j)*ones(n);
    end
  end
end

function A = buildKernel(featureSize)
  if (featureSize == 1)
    A = [1];
  else
    kernelHeight = 2*featureSize-1;
    kernelSpace = linspace(-2, 2, kernelHeight);
    [xx, yy] = meshgrid (kernelSpace, kernelSpace);
    r = xx.^2 + yy.^2;
    rawGauss = exp(-r);
    normingFactor = rawGauss(:)'*ones(kernelHeight^2,1);
    A = rawGauss/normingFactor;
  end
end

function A = noise2d(sizeExp)
  if (sizeExp > 10)
    disp "are you crazy?"
    return
  end
  colormap( repmat( linspace(0, 1, 64)', 1, 3 ) );

  max = sizeExp;
  A = zeros(2^(max+1));
  for i = 1:max-2
    blocksize = 2^(max-i);
    kernel = buildKernel(blocksize);
    B = 2^(max-i)*stretch(randn(2^(1+i)), blocksize);
    C = conv2(B, kernel, "same");
    A += C;
  end
end

imagesc(noise2d(8));
