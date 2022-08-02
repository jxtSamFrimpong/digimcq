def solution(args):
    # your code here
    #print(args)
    args = sorted(args)
    #print(args)

    argy = []
    
    temp = []
    tempCheck = 0
    #print(sorted(args))
    for idx, el in enumerate(args):
        if idx==0:
            temp.append(el)
        else:
            if el-args[idx-1]==1:
                temp.append(el)
                if idx == (len(args)-1):
                    argy.append(temp)
                    break
            else:
                argy.append(temp)
                #print(temp)
                temp = []
                temp.append(el)
                if idx == (len(args)-1):
                    argy.append(temp)
                    break

    resArr = []
    #print(args)
    #print(argy)
    for i in argy:
        if len(i)>2:
            beg = str(i[0]) +'-'+ str(i[-1])
            resArr.append(beg)
        elif len(i)==2:
            resArr.append(str(i[0]))
            resArr.append(str(i[1]))
        else:
            resArr.append(str(i[0]))
    return ','.join(resArr)
            
print(solution([-6,-3,-2,-1,0,1,3,4,5,7,8,9,10,11,14,15,17,18,19,20]))