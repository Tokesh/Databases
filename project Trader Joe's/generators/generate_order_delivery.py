from faker import Faker
import random
import names
import datetime
import radar


fake = Faker()

with open("order_delivery_address.txt", "w")as external_file:
    for i in range(50):
        k = fake.address()[0:15]
        print(f"insert into order_delivery(address) values('%s');" % (k), file = external_file)
    