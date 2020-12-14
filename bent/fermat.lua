-- Note -- the prime factorization really needs to be made
-- much more efficient.  This is good enough for this problem
-- but it lags far behind Python (sympy.factorint).
--
-- It would help if the division only used prime numbers
-- instead of trying every odd value
--
-- I improved it in fermat2.lua which uses prime.lua but it
-- only slightly outperforms sympy.factorint
--
-- Lua version of the Fermat problem solution
--
-- Search for numbers that have an interesting property noted by
-- Fermat.  The sum of the factors of the square of a number are
-- a perfect cube.  The first of these numbers is 1.  What is the
-- next larger integer with this property?

dumpfactor = function(x)
    for i,j in pairs(x) do
        print(j[1],j[2])
    end
end


-- Calculate the prime factors and multiplicities
-- for the given integer.  Returns a list of lists.
-- The primitive list is {prime_factor, multiplicity}.
factorint = function(n)
    local x
    local m
    x={}
    m=0
    while (n%2 == 0) do
        m=m+1
        n=n/2
    end
    if (m ~= 0) then
        table.insert(x,{2,m})
    end
    for i=3,n/2,2 do
        m=0
        while (n%i == 0) do
            m=m+1
            n=n/i
        end
        if (m ~= 0) then
            table.insert(x,{i,m})
        end
        if n==1 then
            break
        end
    end
    if (n ~= 1) then
        table.insert(x,{n,1})
    end
    return(x)
end

sumfactors = function(x)
    local s
    local t
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

search_solution = function(n1,n2)
    local eps
    local x
    local c
    local n

    eps=1e-6  -- need this to prevent round-off error from truncating results

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

