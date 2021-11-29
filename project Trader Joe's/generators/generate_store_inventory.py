import random
import datetime



with open("store_inventory.txt", "w")as external_file:
    for i in range(1,28):
        if(i == 26): continue
        for j in range(1,75):
            k = random.randint(0,1)
            res = 0
            if(k == 0): res = 0
            else: res = random.randint(500,5000)
            brand = random.randint(1,27)
            price = random.randint(50,2500)
            print(f"insert into store_inventory(store_id, product_id, brand_id, price, quantity) values(%s, %s, %s, %s, %s);" % (i, j, brand, price, res),file= external_file)
