import random
import datetime




with open("order.txt", "w")as external_file:
    for i in range(50,99):
        products = {}
        for j in range(random.randint(5,10)):
            k = random.randint(1,75)
            while(k in products): k = random.randint(1,75)
            count = random.randint(1,20)
            print(f"insert into order_items(order_id, product_id, count) values(%s, %s, %s);" % (i, k, count), file = external_file)
        