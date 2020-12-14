-- Attempt to solve the prime number magic
-- square problem in Lua
--
-- Magic square (4x4) composed of prime numbers in the range 1-99.
-- All row totals = 202
-- All col totals = 202
-- Both diag totals = 202
--


valid_grid = function(b)
    local x
    local c
    local prevj
    local d1
    local d2
    -- check to make sure there are 16 unique values
    x={}
    for i1,j1 in ipairs(b) do
        for i2,j2 in ipairs(j1) do
            table.insert(x,j2)
        end
    end
    table.sort(x)
    prevj=-1
    for i,j in ipairs(x) do
        if (j==prevj) then
            return(false)
        end
        prevj=j
    end
    -- check to make sure each column sum is 202
    for c=1,4 do
        if ((b[1][c]+b[2][c]+b[3][c]+b[4][c]) ~= 202) then
            return(false)
        end
    end
    -- check to make sure each diag sum is 202
    d1=b[1][1]+b[2][2]+b[3][3]+b[4][4]
    if (d1 ~= 202) then
        return(false)
    end
    d2=b[4][1]+b[3][2]+b[2][3]+b[1][4]
    if (d2 ~= 202) then
        return(false)
    end
    return(true)
end

dump = function(b)
    for i,j in ipairs(b) do
        for i2,j2 in ipairs(j) do
            io.write("\t" .. j2)
        end
        print()
    end
end

match_start = function(a,x)
    for i,j in ipairs(x) do
        if (a[i] ~= j) then
            return(false)
        end
    end
    return(true)
end


p = {2, 3, 5, 7, 11,13,17,19,23,29,31,37,
    41,43,47,53, 59,61,67,71,73,79,83,89,
    97}

-- master list of feasible rows
a={}
for i1,j1 in ipairs(p) do
    for i2,j2 in ipairs(p) do
        for i3,j3 in ipairs(p) do
            for i4,j4 in ipairs(p) do
                if ((j1 ~= j2) and (j1 ~= j3) and (j1 ~= j4)) then
                    if ((j2 ~= j3) and (j2 ~= j4) and (j3 ~= j4)) then
                        if ((j1+j2+j3+j4)==202) then
                            table.insert(a,{j1,j2,j3,j4})
                        end
                    end
                end
            end
        end
    end
end

-- this should be a list of 3120 permutations
print("Number of feasible rows = ",#a)

-- try each as the first row of the grid
b={{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}}

for i1,j1 in ipairs(a) do -- i1 points to first row
    b[1]=a[i1]
    print("Testing: ",b[1][1],b[1][2],b[1][3],b[1][4])
    for i2,j2 in ipairs(a) do -- i2 points to first col
        if ((i2 ~= i1) and match_start(j2,{b[1][1]})) then
            b[2][1]=j2[2]; b[3][1]=j2[3]; b[4][1]=j2[4]
            for i3,j3 in ipairs(a) do -- i3 points to second row
                feasible=match_start(j3,{b[2][1]})
                if ((i3 ~= i1) and (i3 ~= i2) and feasible ) then
                    b[2]=a[i3]
                    for i4,j4 in ipairs(a) do -- i4 points to second column
                        feasible=match_start(j4,{b[1][2],b[2][2]})
                        if ((i4~=i3) and (i4~=i2) and (i4~=i1) and feasible) then
                            b[3][2]=j4[3]; b[4][2]=j4[4]
                            for i5,j5 in ipairs(a) do -- i5 points to third row
                                feasible=match_start(j5,{b[3][1],b[3][2]})
                                if ((i5~=i4) and (i5~=i3) and (i5~=i2) and (i5~=i1) and feasible) then
                                    b[3]=a[i5]
                                    for i6,j6 in ipairs(a) do -- i6 points to third col
                                        feasible=match_start(j6,{b[1][3],b[2][3],b[3][3]})
                                        feasible=feasible and (i6~=i5) and (i6~=i4) and (i6~=i3)
                                        feasible=feasible and (i6~=i2) and (i6~=i1)
                                        if (feasible) then
                                            b[4][3]=j6[4]
                                            for i7,j7 in ipairs(a) do -- i7 points to 4th row
                                                feasible=match_start(j7,{b[4][1],b[4][2],b[4][3]})
                                                feasible=feasible and (i7~=i6) and (i7~=i5) and (i7~=i4)
                                                feasible=feasible and (i7~=i3) and (i7~=i2) and (i7~=i1)
                                                if (feasible) then
                                                    if (valid_grid(b)) then
                                                        print("Solution:")
                                                        dump(b)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

