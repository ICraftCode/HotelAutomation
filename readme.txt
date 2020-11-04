
1. time is given as timstamp utc format (haven't written test case for this)

2. sensor input format is assumed.. not tested

3. Sensor input is given one after another assuming that's how real world sensor inputs work - inputs in the increasing order of time

4. I have written test cases for the controller class only... 

5. the code has not been exhaustively tested; only a few test cases have been attaced 

6. I had this doubt when the recieved the coding challenge and after clarification from Sahaj, this is the assumption

7. you can run the main.rb or the test case. 


doubt: 
*****************

So my understanding is that the ACs are always switched ON by default and only when the power in the floor exceeds the given limit, we switch OFF the ACs in the Sub-corridors - the problem statement does not specify which sub-corridor and hence I initially assumed all the subcorridors. But as per the given input, it is reflected in only one sub-corridor, so do we start switching off ACs in the subcorridor only until the power falls back within limit (not all subcorridors but the minimum number of subcorridors)? in that case, should we spare the sub-corridor where the current motion is detected? is that a preference that it be airconditioned? or a mandate that the AC should be on when there is a motion detected? I am unclear in this part of the problem statement.


clarification from sahaj:
**********************************

It's not a mandate but the priority should be to turn off other sub-corridors ACs. In Extreme cases, you may require to turn off AC in motion detected sub-corridor

Presently you can go with turning off other sub-corridors ACs if the power limit exceeds.

my final assumption:
***********************************
assuming that i have to turn off "just enough" and "not all" sub-corridor ACs, while having the motion-detected subcorridor as the last option?
