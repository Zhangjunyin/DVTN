function net = cnn_init(varargin)

opts.batchNormalization = true;
opts.networkType = 'simplenn';
opts = vl_argparse(opts,varargin);

rng('default');
rng(0);

net_old = importdata('net.mat');

f = 1/100;
net.layers = {};
net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(7,7,3,32, 'single' )}, ...
                             'biases', {f*randn(1,32, 'single' )}, ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{1}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{1}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 1, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ;

net.layers{end + 1} = struct('type','relu') ;

net.layers{end + 1} = struct('type', 'pool', ...
                             'method', 'max',...
                             'pool', [2 2], ...
                             'stride', 1, ...
                             'pad', [0 1 0 1]) ;

net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(7,7,32,32, 'single')}, ...
                             'biases', {f*randn(1,32, 'single' )}, ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{4}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{4}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 2, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ;

net.layers{end + 1} = struct('type','relu') ;

net.layers{end + 1} = struct('type', 'pool', ...
                             'method', 'max',...
                             'pool', [2 2], ...
                             'stride', 1, ...
                             'pad', [0 1 0 1]) ;

net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(7,7,32,32, 'single')}, ...
                             'biases', {f*randn(1,32, 'single' )}, ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{7}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{7}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 2, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ;

net.layers{end + 1} = struct('type','relu') ;

net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(7,7,32,32, 'single')}, ...
                             'biases', {f*randn(1,32, 'single' )}, ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{9}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{9}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 2, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ;

net.layers{end + 1} = struct('type','relu') ;
%}
net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(7,7,32,64, 'single')}, ...
                             'biases', {f*randn(1,64, 'single' )}, ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{11}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{11}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 2, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ;

net.layers{end + 1} = struct('type', 'conv', ...
                             'filters', {f*randn(1,1,64,2, 'single')}, ...
                             'biases', [0.1676 -0.1676], ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersMomentum', {net_old.layers{12}.filtersMomentum}, ...
                             'biasesMomentum', {net_old.layers{12}.biasesMomentum}, ...
                             'filtersLearningRate', 1, ...
                             'biasesLearningRate', 2, ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 1) ; 
net.layers{end + 1} = struct('type', 'softmax') ;

net.normalization = net_old.normalization;
