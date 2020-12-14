make_trip = function(n)
    n=n or 50
    na=n
    nb=n
    while true do
        if math.random()<0.5 then
            if na==0 then
                return(nb)
            else
                na=na-1
            end
        else
            if nb==0 then
                return(na)
            else
                nb=nb-1
            end
        end
    end
end


num_trials = arg[1] or 1000
num_drinks = arg[2] or 50

n={}
for i=0,num_drinks do n[i]=0 end

t1=os.time()
for trial=1,num_trials do
    k=make_trip()
    n[k]=n[k]+1
end
t2=os.time()

print("Execution time " .. t2-t1)

nmax=0
for i=0,num_drinks do
    if n[i]>0 then
        nmax=i
    end
end

s=0
for i=0,num_drinks do s=s+i*n[i]/num_trials end

print("Number of trials = " .. num_trials)
print("Drinks per card  = " .. num_drinks)
print("Mean drinks remaining = " .. s)
print("Max  drinks remaining = " .. nmax)

for i=0,nmax do print(i,n[i]) end
