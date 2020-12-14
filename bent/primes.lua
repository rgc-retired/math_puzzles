-- Calculate prime numbers using Sieve of Erastophenes (or whatever)
--
-- Note that factorint is used by fermat2.lua
--
-- Note on efficiency: found out that ipairs() is an order of
-- magnitude faster than pairs().  This made a huge difference
-- in the execution speed of factorint().

make_sieve = function(nmax)
    local x
    local sieve
    local i
    local k
    local m
    x={}
    for i=1,nmax do x[i]=1 end
    x[1]=0
    for i=2,nmax do
        if x[i]==1 then
            for k=2,nmax do
                m=i*k
                if m>nmax then
                    break
                end
                x[m]=0
            end
        end
    end
    sieve={}
    for i=1,nmax do
        if x[i]==1 then
            table.insert(sieve,i)
        end
    end
    return(sieve)
end

is_prime = function(n)
    if (n<=primes[#primes]) then
        for i,j in ipairs(primes) do
            if (n==j) then
                return(true)
            end
        end
        return(false)
    else
        if (n%2 == 0) then return(false) end
        for i=3,n/2,2 do
            if (n%i == 0) then return(false) end
        end
        return(true)
    end
end

factorint = function(n)
    local x
    local m
    local i
    local j
    x={}
    for j,i in ipairs(primes) do
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
        if i>n then
            break
        end
    end
    if (n>1) then
        -- Continue the slow way
        for i=primes[#primes],n/2,2 do
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
    end
    if (n ~= 1) then
        table.insert(x,{n,1})
    end
    return(x)
end

primes=make_sieve(10000000)

