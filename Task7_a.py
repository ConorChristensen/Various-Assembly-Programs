"Task 6 part A, Conor Christensen, 27837831."

days = int(input("Please enter the number of days in the selected month: "))
print("Please enter in the temperature for the days sequentially, following each temperature with the return key: ")
templist = []
sortedmessage = "Here is your list of temperatures in increasing order: "
medianmessage = "Here is the median temperature: "

for i in range(days):
    templist.append(int(input()))

#now we use selection sort:  
def sort(alist):
    j=1
    for i in range(len(alist)):
        minimum = alist[i]
        swap = False
        for n in range(-len(alist)+j,0):

            if alist[n] <= minimum:
                minimum = alist[n]
                index = n
                swap = True
        if swap == True:
            temp = alist[i]
            alist[i] = minimum
            alist[index] = temp

        j+=1
    return alist

def findMedian(alist):
    size = len(alist)
    if size % 2 == 0:
        index1 = size//2
        index1 -= 1
        index2 = size//2
        add = alist[index2] - alist[index1]
        median = alist[index1] + add
        return median
    else:
        index = size // 2
        index += 1
        median = alist[index]
        return median
    
print(sortedmessage)
print(sort(templist))
print(medianmessage)
print(findMedian(templist))
