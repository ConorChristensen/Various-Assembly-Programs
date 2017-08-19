"Task 8 part A, Conor Christensen, 27837831."

days = int(input("Please enter the number of days in the selected month: "))
print("Please enter in the temperature for the days sequentially, following each temperature with the return key: ")
templist = []
sortedmessage = "Here is your list of temperatures in increasing order: "
found = "The temperature is in the month."
notfound = "The temperature is not in the month."
for i in range(days):
    templist.append(int(input()))

temp = int(input("Please enter in the temperature you wish to find: "))
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


def binarySearch(alist, target, lowestindex, highestindex):
    if (highestindex < lowestindex):
        return False
    else:
        middleindex = lowestindex + ((highestindex - lowestindex) // 2)
        if alist[middleindex] > target:
            return binarySearch(alist, target, lowestindex, middleindex-1)
        elif alist[middleindex] < target:
            return binarySearch(alist, target, middleindex+1, highestindex)
        else:
            return True
    

print(sortedmessage)
print(sort(templist))

if binarySearch(templist, temp, 0, days-1) == True:
    print(found)

if binarySearch(templist, temp, 0, days-1) == False:
    print(notfound)
