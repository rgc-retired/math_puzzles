--[[
Given 14 flavors of donuts.
Grab a dozen.

How many different flavors?
P(3 or fewer flavors)?
--]]

num_trials=100000000
n={}
total={}
for i=1,14 do total[i]=0 end

for trial=1,num_trials do
    -- Zero out donut counts
    for i=1,14 do n[i]=0 end
    -- Pick random dozen donuts
    for i=1,12 do
        k=math.random(14)
        n[k]=n[k]+1
    end
    -- Count num diff flavors
    -- for this trial
    num_flavors=0
    for i=1,14 do
        if n[i] ~= 0 then
            num_flavors = num_flavors + 1
        end
    end
    -- Count for all trials
    total[num_flavors] = total[num_flavors]+1
end

print("Num trials = " .. num_trials)
for i=1,14 do
print(i,total[i])
end

