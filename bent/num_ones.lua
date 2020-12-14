-- Determine number of 1 digits in the string
-- representation of n
num_ones = function(n)
    c=0
    s=string.format('%d',n)
    for i=1,string.len(s) do
        if string.sub(s,i,i)=="1" then
            c=c+1
        end
    end
    return(c)
end


-- Search the range of numbers from n1 to n2
-- and output any values equal the number of ones
-- in all the values from 1 to n inclusive.
search_range = function(n1,n2)
    c0=0
    if n1>1 then
        for i=1,(n1-1) do
            c0=c0+num_ones(i)
        end
    end
    for i=n1,n2 do
        c0=c0+num_ones(i)
        if (i==c0) then
            print(i)
        end
    end
end

