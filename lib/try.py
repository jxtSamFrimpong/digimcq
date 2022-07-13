from itertools import permutations

def next_bigger(number):
    str_rep = str(number)
    str_int_rep = [int(i) for i in str_rep]
    
    for idx, j in reversed(list(enumerate(str_int_rep))):
        
        if idx!=len(str_rep)-1:
            if str_int_rep[idx]<str_int_rep[idx+1]:
                tul = []
                for _ in list(permutations(str_rep[idx:])):
                    
                    if int(''.join([i for i in _]))>int(str_rep[idx:]):
                        tul.append(int(''.join([i for i in _])))
                
                minPatch = str(min(tul))
                return int(str_rep[:idx]+minPatch)

    return -1

print(next_bigger(5))