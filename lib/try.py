def fib_rabbits(n, b):
    # your code here
    mature = 0
    immature = 1
    old_mature = 0

    for i in range(1, n+1):
        old_mature = mature
        mature = mature + immature
        immature = old_mature * b
        #print(i)
    return mature

print(fib_rabbits(5,3))