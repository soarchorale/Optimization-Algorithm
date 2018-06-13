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

classdef CROStatistic < handle
    
    properties
        sampleMol;
        optMol;
        repMol = [];
        optGlobal = 1E300;
        repGlobal;
        repTime;
        covData;
        covFE;
    end
    
    properties(Access = private)
        repeats;
        numCovData;
        covFEIndex;
        FELimit;
    end
    
    methods
        function self = CROStatistic(mol, inRepeats, inNumCovData, inFELimit)
            self.sampleMol = mol.clone();
            self.repeats = inRepeats;
            self.numCovData = inNumCovData;
            self.FELimit = inFELimit;
            for i = 1:self.repeats
                newMol = self.sampleMol.clone();
                self.repMol = [self.repMol newMol];
            end
            self.optMol = self.sampleMol.clone();
            self.covData = zeros(self.repeats, self.numCovData);
            self.repGlobal = zeros(1, self.repeats);
            self.repTime = zeros(1, self.repeats);
            self.covFE = zeros(1, self.numCovData);
            self.covFEIndex = 1;
            intv = self.FELimit/self.numCovData;
            for i = 1:self.numCovData
                self.covFE(i) = floor(i * intv);
            end
        end
        
        function repUpdate(self, curRep, inRepGlobal, inRepMol, inRepTime)
            self.repGlobal(curRep) = inRepGlobal;
            self.repMol(curRep).copy(inRepMol);
            self.repTime(curRep) = inRepTime;
            if (inRepGlobal < self.optGlobal)
                self.optGlobal = inRepGlobal;
                self.optMol.copy(inRepMol);
            end
            self.covFEIndex = 1;
        end
        
        function covUpdate(self, curRep, curFE, repGlobal)
            if curFE >= self.covFE(self.covFEIndex)
                self.covData(curRep, self.covFEIndex) = repGlobal;
                self.covFEIndex = self.covFEIndex + 1;
            end
        end
    end
    
end

