dump_array = function(a)
    for i,j in pairs(a) do
        for i2,j2 in pairs(j) do
            io.write(' ' .. j2)
        end
        print()
    end
end

-- Check that a particular permutation has 2 of each digit: 1..n
check_perm_digits = function(a,n)
    c={}
    for i=1,n do c[i]=0 end
    for i,j in pairs(a) do
        c[j]=c[j]+1
    end
    for i=1,n do 
        if (c[i] ~= 2) then
            return(false)
        end
    end
    return(true)
end

-- Check to see if a row in x already exists in the array(a)
-- Return true if the row is found
row_exists = function(a,x)
    n=#x
    for i,j in pairs(a) do
        m=0
        for k=1,n do
            if (j[k] == x[k]) then
                m=m+1
            else
                break
            end
        end
        if (m==n) then
            return(true)
        end
    end
    return(false)
end

-- Add new permutation pattern to the array(a)
-- Unless it is a duplicate, or shifted duplicate, of
-- an existing row in a
add_perm_row = function(a,x)
    local y
    local z
    local n
    y={}
    z={}
    n=#x
    for i,j in pairs(x) do table.insert(y,j); table.insert(z,j) end
    for shift_count=1,10 do
        if (row_exists(a,y)) then
            return
        end
        -- Create reverse of the vector and check again
        for k=1,n do z[n-k+1]=y[k] end
        if (row_exists(a,z)) then
            return
        end
        -- Circular shift the vector
        temp=y[1]
        for i=2,#y do y[i-1]=y[i] end
        y[#y]=temp
    end
    table.insert(a,x)
    -- print(#a)
end


t1=os.clock()
b={}
for d1=1,5 do
    for d2=1,5 do
        for d3=1,5 do
            for d4=1,5 do
                for d5=1,5 do
                    for d6=1,5 do
                        for d7=1,5 do
                            for d8=1,5 do
                                for d9=1,5 do
                                    for d10=1,5 do
                                        a={d1,d2,d3,d4,d5,d6,d7,d8,d9,d10}
                                        if (check_perm_digits(a,5)) then
                                            add_perm_row(b,a)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            print(d1 .. d2 .. d3 .. "   " .. #b)
        end
    end
end
t2=os.clock()
-- dump_array(b)

print("Number of solutions = " .. #b)
print("Solution time (secs) = " .. t2-t1)

