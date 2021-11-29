import random
with open("vendors_delivery.txt", "w")as external_file:
    for i in range(1,25):
        zxc = {}
        for j in range(random.randint(1,10)):
            k = random.randint(1,27)
            while(k in zxc and k != i): 
                k = random.randint(1,27)
            zxc[k] = 1
            print(f"insert into vendor_delivery(vendor_id, brand_id) values(%s, %s);" % (i,k), file = external_file)
            
