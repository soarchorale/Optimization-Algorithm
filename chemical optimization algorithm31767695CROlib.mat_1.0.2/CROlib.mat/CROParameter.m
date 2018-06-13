%
%  
%  "Chemical Reaction Optimization" 
%  
%  Copyright 2013 The University of Hong Kong ("HKU"). All Rights Reserved. 
%  
% 
%  This file is licensed to you ("You") for academic and non-commercial 
%  internal research purpose only subject to the terms and conditions of the 
%  license agreement downloadable from the HKU website (the "License"); You may 
%  not use this file except in compliance with the License. You may obtain a 
%  copy of the License at
%  
%  	http://cro.eee.hku.hk/license.txt
%  
%  
%  This file is provided on an 'as is' and 'as available" basis without warranty of
%  any kind, either express or implied, including, but not limited to, the implied
%  warranties of fitness for a particular purpose, merchantability,
%  non-infringement or security. 
%      
%   
%  In no event, including (without limitation) negligence, shall HKU, its
%  subsidiaries, affiliates, agents, officers, directors, employees, partners, or
%  suppliers be liable to You or any third party for any direct, indirect,
%  incidental, special, exemplary, or consequential damages (including, but not
%  limited to, procurement of substitute goods or services; loss of use, data, or
%  profits; or business interruption) however caused and on any theory of
%  liability, whether in contract, strict liability, or tort (including negligence
%  or otherwise) arising in any way out of the use of this file, even if advised of
%  the possibility of such damage.
%      
%   
%  See the License for the specific language governing permissions and limitations
%  under the License.
%  
%  
%

 
classdef CROParameter < handle
    
    properties
        repeats = 1;
        FELimit = 100000;
        iniPopSize = 10;
        decThres = 1000;
        numCovData = 1000;
        iniKE = 0;
        iniBuffer = 0;
        collRate = 0.2;
        lossRate = 0.2;
        synThres = 10;
    end
    
    methods
        function self = CROParameter(varargin)
            if nargin == 1
                param = importdata(varargin{1});
                for i = 1:length(param.rowheaders)
                    self.parseConfig(param.rowheaders(i), param.data(i));
                end
            end
        end
        
        function parseConfig(self, name, value)
            if strcmp(name,'REP')
                self.repeats = value;
            elseif strcmp(name, 'FEL')
                self.FELimit = value;
            elseif strcmp(name, 'IPS')
                self.iniPopSize = value;
            elseif strcmp(name, 'IKE')
                self.iniKE = value;
            elseif strcmp(name, 'IBF')
                self.iniBuffer = value;
            elseif strcmp(name, 'CRT')
                self.collRate = value;
            elseif strcmp(name, 'LRT')
                self.lossRate = value;
            elseif strcmp(name, 'DTH')
                self.decThres = value;
            elseif strcmp(name, 'STH')
                self.synThres = value;
            elseif strcmp(name, 'NCD')
                self.numCovData = value;
            end
        end
    end
    
end

