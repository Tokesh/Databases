f = open('myfile.txt', 'r')
with open("brands.txt", "w")as external_file:
    for i in f:
        s = f.readline().strip()
        print(f"insert into brands(brand_name) values('%s');" % s, file = external_file)
f.close()