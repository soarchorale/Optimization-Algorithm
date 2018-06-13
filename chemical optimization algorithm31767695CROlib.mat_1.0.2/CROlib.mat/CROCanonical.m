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

classdef CROCanonical < handle
    
    properties
        param;
        stat;
    end
    
    properties(Access = private)
        sampleMol;
        t1;
        t2;
        repMol;
        curFE = 0;
        eBuffer = 0;
        repGlobal = 1E300;
        pop;
    end
    
    methods
        function self = CROCanonical(varargin)
            self.sampleMol = varargin{1};
            if nargin == 1
                self.param = CROParameter();
            elseif nargin == 2
                self.param = varargin{2};
            end
            self.t1 = self.sampleMol.clone();
            self.t2 = self.sampleMol.clone();
            self.repMol = self.sampleMol.clone();
        end
        
        function opt = run(self)
            self.stat = CROStatistic(self.sampleMol, self.param.repeats,...
                self.param.numCovData, self.param.FELimit);
            for repeats = 1:self.param.repeats
                start = clock();
                self.repGlobal = 1E300;
                self.pop = [];
                for i = 1:self.param.iniPopSize
                    m = self.sampleMol.clone();
                    self.initMol(m);
                    self.pop = [self.pop m];
                    self.update(m);
                end
                self.curFE = self.param.iniPopSize;
                self.eBuffer = self.param.iniBuffer;
                while self.curFE < self.param.FELimit
                    if (rand > self.param.collRate) || ...
                            (length(self.pop) == 1)
                        pos = ceil(rand * length(self.pop));
                        if self.pop(pos).isInactive(self.param.decThres)
                            m = self.sampleMol.clone();
                            self.initMol(m);
                            if self.dec(self.pop(pos), m)
                                self.pop = [self.pop m];
                                self.update(self.pop(pos));
                                self.update(m);                                
                            end
                            self.curFE = self.curFE + 2;
                        else
                            self.wall(self.pop(pos));
                            self.update(self.pop(pos));
                            self.curFE = self.curFE + 1;
                        end
                    else
                        pos1 = ceil(rand * length(self.pop));
                        pos2 = pos1;
                        while (pos1 == pos2)
                            pos2 = ceil(rand * length(self.pop));
                        end
                        if (self.pop(pos1).KE < self.param.synThres) && ...
                                (self.pop(pos2).KE < self.param.synThres)
                            if self.syn(self.pop(pos1), self.pop(pos2))
                                self.update(self.pop(pos1));
                                self.pop(pos2) = [];
                            end
                            self.curFE = self.curFE + 1;
                        else
                            self.inter(self.pop(pos1), self.pop(pos2))
                            self.update(self.pop(pos1));
                            self.update(self.pop(pos2));
                            self.curFE = self.curFE + 2;
                        end
                    end
                    self.stat.covUpdate(repeats, self.curFE, self.repGlobal);
                end
                self.stat.repUpdate(repeats, self.repGlobal, ...
                    self.repMol, etime(clock(), start));
            end
            opt = self.stat.optGlobal;
        end
    end
    
    methods(Access = private)
        function initMol(self, m)
            if isempty(m.oprFit)||isempty(m.oprWall)||...
                    isempty(m.oprDec)||isempty(m.oprInter)||...
                    isempty(m.oprSyn)
                error(['Missing operator. Error code ' ...
                    num2str(int8(isempty(m.oprFit))) ...
                    num2str(int8(isempty(m.oprWall))) ...
                    num2str(int8(isempty(m.oprDec))) ...
                    num2str(int8(isempty(m.oprInter))) ...
                    num2str(int8(isempty(m.oprSyn)))]);
            end
            m.minHitIndex = 0;
            m.curHitIndex = 0;
            m.KE = self.param.iniKE;
            m.PE = m.oprFit(m);
            m.optLocal = m.PE;
        end
        
        function update(self, m)
            if m.PE < self.repGlobal
                self.repGlobal = m.PE;
                self.repMol.copy(m);
            end
        end
        
        function wall(self, m)
            m.curHitIndex = m.curHitIndex + 1;
            invokeWall(self, m);
            tempPE = m.oprFit(self.t1);
            excessEnergy = m.PE + m.KE - tempPE;
            if excessEnergy >= 0
                m.PE = tempPE;
                m.KE = excessEnergy * ((1 - self.param.lossRate) * rand() + ...
                    self.param.lossRate);
                m.copy(self.t1);
                m.update();
                self.eBuffer = self.eBuffer + excessEnergy - m.KE;
            end
        end
        
        function invokeWall(self, m)
            m.oprWall(m, self.t1);
        end
        
        function success = dec(self, m1, m2)
            success = false;
            m1.curHitIndex = m1.curHitIndex + 1;
            invokeDec(self, m1);
            tempPE1 = m1.oprFit(self.t1);
            tempPE2 = m2.oprFit(self.t2);
            excessEnergy = m1.PE + m1.KE - tempPE1 - tempPE2;
            if (excessEnergy >= 0) || (excessEnergy + self.eBuffer >= 0)
                if excessEnergy >= 0
                    m1.KE = excessEnergy * rand();
                    m2.KE = excessEnergy - m1.KE;
                else
                    self.eBuffer = self.eBuffer + excessEnergy;
                    m1.KE = excessEnergy * rand() * rand();
                    self.eBuffer = self.eBuffer - m1.KE;
                    m2.KE = excessEnergy * rand() * rand();
                    self.eBuffer = self.eBuffer - m2.KE;
                end
                m1.minHitIndex = 0;
                m1.curHitIndex = 0;
                m1.PE = tempPE1;
                m1.copy(self.t1);
                m1.update();
                m2.PE = tempPE2;
                m2.copy(self.t2);
                m2.update();
                success = true;
            end
        end
        
        function invokeDec(self, m1)
            m1.oprDec(m1, self.t1, self.t2);
        end
        
        function inter(self, m1, m2)
            m1.curHitIndex = m1.curHitIndex + 1;
            m2.curHitIndex = m2.curHitIndex + 1;
            invokeInter(self, m1, m2);
            tempPE1 = m1.oprFit(self.t1);
            tempPE2 = m2.oprFit(self.t2);
            excessEnergy = m1.PE + m1.KE + m2.PE + m2.KE - tempPE1 - tempPE2;
            if excessEnergy >= 0
                m1.PE = tempPE1;
                m1.KE = excessEnergy * rand();
                m1.copy(self.t1);
                m1.update();
                m2.PE = tempPE2;
                m2.KE = excessEnergy * rand();
                m2.copy(self.t2);
                m2.update();
            end
        end
        
        function invokeInter(self, m1, m2)
            m1.oprInter(m1, m2, self.t1, self.t2);
        end
        
        function success = syn(self, m1, m2)
            success = false;
            m1.curHitIndex = m1.curHitIndex + 1;
            invokeSyn(self, m1, m2);
            tempPE = m1.oprFit(self.t1);
            excessEnergy = m1.PE + m1.KE + m2.PE + m2.KE - tempPE;
            if excessEnergy >= 0
                m1.minHitIndex = 0;
                m1.curHitIndex = 0;
                m1.PE = tempPE;
                m1.KE = excessEnergy;
                m1.copy(self.t1);
                m1.update();
            end
        end
        
        function invokeSyn(self, m1, m2)
            m1.oprSyn(m1, m2, self.t1);
        end
    end
    
end

