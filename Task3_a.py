size = int(input("Please enter the size of the list: "))
the_list = []
listsum = 0
listaverage = 0
for i in range(size):
    the_list.append(input("Please enter a number to be appended to the list: "))

i = 0

while i < size:
    listsum += int(the_list[i])
    i = i+1

listaverage = listsum/size
print(listaverage)
    
