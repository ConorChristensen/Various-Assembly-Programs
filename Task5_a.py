"Task 5 part A, Conor Christensen, 27837831"

days = int(input("Please enter the number of days in the selected month: "))
print("Please enter in the temperature for the days sequentially, following each temperature with the return key: ")
templist = []
condition = False

for i in range(days):
    templist.append(int(input()))

temp = int(input("Please enter in the temperature you wish to find: "))

def findTemp(temp): 
    for item in templist:
        if item == temp :
            return True
    return False
if findTemp(temp) == True:
    print("The temperature exists in the month.")

if findTemp(temp) == False:
    print("The temperature does not exist in the month.")

    
