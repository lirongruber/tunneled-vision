% Flat vectorizes a matrix
function [fl] = Flat(mat)
fl = reshape(mat,numel(mat),1);