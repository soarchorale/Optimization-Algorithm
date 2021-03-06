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
%      http://cro.eee.hku.hk/license.txt
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

classdef CROMolecule1DArrayInt < CROMolecule1DArray
    
    properties
        limLow;
        limHigh;
    end
    
    methods
        function self = CROMolecule1DArrayInt(l, low, high, fit)
            self = self@CROMolecule1DArray(l);
            self.limLow = low;
            self.limHigh = high;
            self.oprFit = fit;
            self.oprWall = @CROMolecule1DArrayIntWall;
            self.oprDec = @CROMolecule1DArrayIntDec;
            self.oprInter = @CROMolecule1DArrayIntInter;
            self.oprSyn = @CROMolecule1DArrayIntSyn;
            for i = 1:l
                self.solution(i) = CRORandInt(self.limLow, self.limHigh);
            end
        end
        
        function m = clone(self)
            m = CROMolecule1DArrayDouble(self.length, ...
                self.limLow, self.limHigh, self.oprFit);
        end
        
    end
    
end

function CROMolecule1DArrayIntWall(in, out)
    out.copy(in);
    pos = ceil(rand() * in.length);
    out.solution(pos) = CRORandInt(self.limLow, self.limHigh);
end

function CROMolecule1DArrayIntDec(in1, out1, out2)
    out1.copy(in1);
    out2.copy(in1);
    for i = 1:in1.length
        if rand() > 0.5
            out1.solution(i) = CRORandInt(self.limLow, self.limHigh);
        else
            out2.solution(i) = CRORandInt(self.limLow, self.limHigh);
        end
    end
end

function CROMolecule1DArrayIntInter(in1, in2, out1, out2)
    for i = 1:in1.length
        if rand() > 0.5
            out1.solution(i) = in1.solution(i);
            out2.solution(i) = in2.solution(i);
        else
            out1.solution(i) = in2.solution(i);
            out2.solution(i) = in1.solution(i);
        end
    end
end

function CROMolecule1DArrayIntSyn(in1, in2, out1)
    out1.copy(in1);
    for i = 1:in1.length
        if rand() > 0.5
            out1.solution(i) = in2.solution(i);
        end
    end
end

function result = CRORandInt(low, high)
    result = floor(rand() * (high - low + 1)) + low;
end
