function tab=Gray(n)

% Default N:=255;
if nargin == 0
    n=255;
end

% RGB f�rgtabellen. En rad per pixel i PIX.
tab=gray(n);
