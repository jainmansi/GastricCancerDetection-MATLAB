function stats = grayrlprops(varargin)

% Check GLRLM
[GLRLM numGLRLM] = ParseInputs(varargin{:});


numStats = 11;

stats = zeros(numGLRLM,numStats);

for p = 1 : numGLRLM
    %N-D indexing not allowed for sparse.

    if numGLRLM ~= 1
        % transfer to double matrix
        tGLRLM = GLRLM{p};
    else
        tGLRLM = GLRLM;
    end
   
    s = size(tGLRLM);
    % colum indicator
    c_vector =1:s(1);
    % row indicator
    r_vector =1:s(2);
    
    [c_matrix,r_matrix] = meshgrid(c_vector,r_vector);

    % Total number of runs
    N_runs = sum(sum(tGLRLM));

    % total number of elements
    N_tGLRLM = s(1)*s(2);

   
    p_g = sum(tGLRLM);

    p_r = sum(tGLRLM,2)';

    
    SRE = sum(p_r./(c_vector.^2))/N_runs;
    % 2. Long Run Emphasis (LRE)
    LRE = sum(p_r.*(c_vector.^2))/N_runs;
    % 3. Gray-Level Nonuniformity (GLN)
    GLN = sum(p_g.^2)/N_runs;
    % 4. Run Length Nonuniformity (RLN)
    RLN = sum(p_r.^2)/N_runs;
    % 5. Run Percentage (RP)
    RP = N_runs/N_tGLRLM;
    % 6. Low Gray-Level Run Emphasis (LGRE)
    LGRE = sum(p_g./(r_vector.^2))/N_runs;
    % 7. High Gray-Level Run Emphasis (HGRE)
    HGRE = sum(p_g.*r_vector.^2)/N_runs;
    % 8. Short Run Low Gray-Level Emphasis (SRLGE)
    SGLGE =calculate_SGLGE(tGLRLM,r_matrix',c_matrix',N_runs);
    % 9. Short Run High Gray-Level Emphasis (SRHGE)
    SRHGE =calculate_SRHGE(tGLRLM,r_matrix',c_matrix',N_runs);
    % 10. Long Run Low Gray-Level Emphasis (LRLGE)
    LRLGE =calculate_LRLGE(tGLRLM,r_matrix',c_matrix',N_runs);
    % 11.Long Run High Gray-Level Emphasis (LRHGE
    LRHGE =calculate_LRHGE(tGLRLM,r_matrix',c_matrix',N_runs);
    %----------------insert statistics----------------------------
    stats(p,:)=[SRE LRE GLN RLN  RP LGRE HGRE SGLGE SRHGE LRLGE  LRHGE ];
end % end all run length matrixs

function SGLGE =calculate_SGLGE(tGLRLM,r_matrix,c_matrix,N_runs)
% Short Run Low Gray-Level Emphasis (SRLGE):

term = tGLRLM./((r_matrix.*c_matrix).^2);
SGLGE= sum(sum(term))./N_runs;

%------------------------------------
function  SRHGE =calculate_SRHGE(tGLRLM,r_matrix,c_matrix,N_runs)
% Short Run High Gray-Level Emphasis (SRHGE):
%
term  = tGLRLM.*(r_matrix.^2)./(c_matrix.^2);
SRHGE = sum(sum(term))/N_runs;
%------------------------------------
function   LRLGE =calculate_LRLGE(tGLRLM,r_matrix,c_matrix,N_runs)
% Long Run Low Gray-Level Emphasis (LRLGE):
%
term  = tGLRLM.*(c_matrix.^2)./(r_matrix.^2);
LRLGE = sum(sum(term))/N_runs;
%---------------------------------------
function  LRHGE =calculate_LRHGE(tGLRLM,r_matrix,c_matrix,N_runs)
% Long Run High Gray-Level Emphasis (LRHGE):
%
term  = tGLRLM.*(c_matrix.^2).*(r_matrix.^2);
LRHGE = sum(sum(term))/N_runs;

function [glrlm num_glrlm] = ParseInputs(varargin)
% check stability of inputs
%
% first receive all inputs
glrlm = varargin{:};
% get numbers total
num_glrlm=length(glrlm);
% then for each element, check its stability
for i=1:num_glrlm
    % The 'nonnan' and 'finite' attributes are not added to iptcheckinput because the
    % 'integer' attribute takes care of these requirements.
    % iptcheckinput(glrlm,{'cell'},{'real','nonnegative','integer'}, ...
    % mfilename,'GLRLM',1);
    iptcheckinput(glrlm{i},{'logical','numeric'},{'real','nonnegative','integer'},...
        mfilename,'GLRLM',1);
    % Cast GLRLM to double to avoid truncation by data type. Note that GLRLM is not an
    % image.
    if ~isa(glrlm,'double')
        glrlm{i}= double(glrlm{i});
    end
end
