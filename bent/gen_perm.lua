-- Determine if a number is prime
is_prime = function(n)
    result=true
    if n%2==0 then
        result=false
    else
        for i=3,math.sqrt(n),2 do
            if n%i == 0 then
                result=false
                break
            end
        end
    end
    return(result)
end

-- Put the code to process each permutation here
process_perm = function(a)
    -- print(string.rep('*',80))
    for i,j in pairs(a) do io.stdout:write(' ' .. j) end
    print()
end

-- Function to generate all permutations of k elements in a[].
-- Uses heap method (from Wikipedia pseudo-code)
--
-- This function should be called with k=number of elements in a[]
-- Elements in a should be at a[1], a[2], ..., a[k]
--
-- As a side effect of this function the elements of a[] will
-- be reordered.
gen_perm = function(k,a)
    if (k==1) then
        process_perm(a)
    else
        gen_perm(k-1,a)
        for i=1,(k-1) do
            if (k%2 == 0) then
                a[i],a[k]=a[k],a[i]
            else
                a[1],a[k]=a[k],a[1]
            end
            gen_perm(k-1,a)
        end
    end
end

test_gen_perm = function(a)
    zzz={}
    process_perm = function(a)
        table.insert(zzz,a)
    end
    a=a or {1,2,3}
    k=#a

    gen_perm(k,a)

    print("Length of sequence = " .. k)
    print("Number of permutations = " .. #zzz)
end

