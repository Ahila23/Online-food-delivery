import pandas as pd
import pymysql

import sqlalchemy as sqlalchemy 
from sqlalchemy import create_engine


engine = create_engine("mysql+pymysql://root:12345@localhost:3306/Online_food_delivery")

# CSV file path
file_path = r"C:\Users\User\Desktop\New OFD\cleaned_online_food_delivery_dataset.csv"

# Load CSV
df = pd.read_csv(file_path)

print("Dataset loaded")
print("Shape:", df.shape)

# MySQL connection
engine = create_engine("mysql+pymysql://root:12345@localhost:3306/Online_food_delivery")

# Upload dataframe to MySQL
df.to_sql("online_food_delivery", engine, if_exists="replace", index=False)

print("Data uploaded to MySQL successfully!")
