-- Lua version of the Fermat problem solution
-- Improved from fermat.lua

dofile("primes.lua")

dumpfactor = function(x)
    for i,j in pairs(x) do
        print(j[1],j[2])
    end
end


sumfactors = function(x)
    s=1
    for i,j in pairs(x) do
        t=1
        for k=1,j[2] do
            t=t*j[1]+1
        end
        s=s*t
    end
    return(s)
end

-- Search for numbers that have an interesting property noted by
-- Fermat.  The sum of the factors of the square of a number are
-- a perfect cube.  The first of these numbers is 1.  What is the
-- next larger integer with this property?

search_solution = function(n1,n2)
    local eps
    local x
    local c
    local n

    eps=1e-6

    n1=n1 or 1
    n2=n2 or 100

    for n=n1,n2 do
        x=factorint(n)
        for k=1,#x do x[k][2]=2*x[k][2] end
        target=sumfactors(x)
        c=math.floor(math.pow(target,1/3)+eps)
        if (c*c*c == target) then
            print("Solution = " .. n)
        end
    end
end
