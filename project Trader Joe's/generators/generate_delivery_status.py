from faker import Faker
import random
import names
import datetime
import radar

zxc = {}
with open("delivery_status.txt", "w")as external_file:
    for i in range(1,21):
        date=datetime.date(random.randint(2020,2021), random.randint(1,12),random.randint(1,28))
        for j in range(random.randint(1,3)):
            if(j == 0):
                print(f"insert into delivery_status(order_delivery_id, date_time, status) values(%s, '%s', 'Unloaded');" % (i, date) , file = external_file)
            if(j == 1):
                print(f"insert into delivery_status(order_delivery_id, date_time, status) values(%s, '%s', 'Left the warehouse');" % (i, date + datetime.timedelta(days=random.randint(0,10))) , file = external_file)
            if(j == 2):
                    print(f"insert into delivery_status(order_delivery_id, date_time, status) values(%s, '%s', 'Delivered');" % (i, date + datetime.timedelta(days=random.randint(9,15))) , file = external_file)