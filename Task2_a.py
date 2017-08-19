size = int(input("Please enter the size of the list: "))
size2 = size+1
reverse_list = []
the_list = []
for i in range(size):
    the_list.append(input("Please enter a number to be appended to the list: "))

i = -1

while i*-1 < size2:
    reverse_list.append(the_list[i])
    i = i-1

print(reverse_list)
    
