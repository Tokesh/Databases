from faker import Faker
import random
import names
import datetime
import radar
def random_phone_num_generator():
    first = str(random.randint(100, 999))
    second = str(random.randint(1, 888)).zfill(3)
    last = (str(random.randint(1, 9998)).zfill(4))
    while last in ['1111', '2222', '3333', '4444', '5555', '6666', '7777', '8888']:
        last = (str(random.randint(1, 9998)).zfill(4))
    return '{}-{}-{}'.format(first, second, last)

fake = Faker()

f = open('food_vendors.txt', 'r')
with open("food_vendors_commands.txt", "w")as external_file:
    for i in f:
        s = i.strip()
        k = fake.address()[0:15]
        num = random_phone_num_generator()
        print(f"insert into vendors(vendor_name, address, phone_number) values('%s', '%s', '%s');" % (s,k,num), file = external_file)
f.close()