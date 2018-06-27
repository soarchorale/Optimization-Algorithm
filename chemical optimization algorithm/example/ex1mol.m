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

classdef ex1mol < CROMolecule
    
    properties
        x;
        N;
    end
    
    methods
        function self = ex1mol()
            self.oprFit = @ex1fit;
            self.oprWall = @molWall;
            self.oprDec = @molDec;
            self.oprInter = @molInter;
            self.oprSyn = @molSyn;
            self.N = 2;
            self.x = rand(1,2);
        end
		
		function m = clone(self)
			m = ex1mol();
		end
        
        function copy(self, from)
            self.x = from.x;
        end
    end
    
end

function molWall(in, out)
    out.copy(in);
    pos = ceil(rand() * in.N);
    out.x(pos) = out.x(pos) + randn;
end

function molDec(in1, out1, out2)
    out1.copy(in1);
    out2.copy(in1);
    for i = 1:in1.N
        if rand() > 0.5
            out1.x(i) = out1.x(i) + randn;
        else
            out2.x(i) = out2.x(i) + randn;
        end
    end
end

function molInter(in1, in2, out1, out2)
    for i = 1:in1.N
        if rand() > 0.5
            out1.x(i) = in1.x(i);
            out2.x(i) = in2.x(i);
        else
            out1.x(i) = in2.x(i);
            out2.x(i) = in1.x(i);
        end
    end
end

function molSyn(in1, in2, out1)
    out1.copy(in1);
    for i = 1:in1.N
        if rand() > 0.5
            out1.x(i) = in2.x(i);
        end
    end
end
