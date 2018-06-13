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

% Create a CRO object. In the construction period, the initial environment
% of the container, including initial population, energy buffer, etc., is
% created.
m = ex1mol();
c1 = CROCanonical(m);

% The above initialization has no parameter as input, so CROlib will
% initialize one for you. However, you can change the default parameter
% after you have create the CRO object as follows.
c1.param.repeats = 3;
c1.param.FELimit = 1000;
c1.param.iniKE = 100;

% You can also initialize one as input as follows.
p = CROParameter('ex1conf.txt');
c2 = CROCanonical(m, p);

% Certainly it is fine if you want to add some parameter to the original
% CRO parameters by creating a new class inherited from CROParameter class.
% Again, do not worry about the memory employed by the above CROParameter
% object. It will be release with the release of CRO object.

% After everything is done, run the algorithm! The run() function will
% return the final global optimum got by CRO.
disp(c1.run());
disp(c1.stat.optMol.x);