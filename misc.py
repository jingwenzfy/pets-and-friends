import pandas as pd
from faker import Faker
import random
import datetime

# Initialize Faker for realistic data
fake = Faker()

# Set the date range for JoinDate and DOB
start_date_join = datetime.datetime(2023, 1, 1)
end_date_join = datetime.datetime(2024, 12, 31)
start_date_dob = datetime.datetime(1950, 1, 1)
end_date_dob = datetime.datetime(2005, 12, 31)

# Generate data for each column
user_data = {
    "FName": [fake.first_name() for _ in range(950)],
    "MI": [fake.random_uppercase_letter() for _ in range(950)],
    "LName": [fake.last_name() for _ in range(950)],
    "DOB": [fake.date_between(start_date=start_date_dob, end_date=end_date_dob).strftime("%Y-%m-%d") for _ in range(950)],
    "Gender": [fake.random_element(elements=["Male", "Female", "Non-Binary"]) for _ in range(950)],
    "Email": [fake.email() for _ in range(950)],
    "Phone": [fake.phone_number() for _ in range(950)],
    "Password": [fake.password(length=8) for _ in range(950)],
    "StreetAddress": [fake.street_address() for _ in range(950)],
    "Apartment": [fake.secondary_address() if random.random() > 0.7 else '' for _ in range(950)],  # 30% chance of having an apartment
    "City": [fake.city() for _ in range(950)],
    "State": [fake.state_abbr() for _ in range(950)],
    "ZIP": [fake.zipcode() for _ in range(950)],
    "JoinDate": [fake.date_between(start_date=start_date_join, end_date=end_date_join).strftime("%Y-%m-%d") for _ in range(950)]
}

# Create the DataFrame
df_users = pd.DataFrame(user_data)

# Save the DataFrame to a CSV file
df_users.to_csv('user_data.csv', index=False)

print("user_data.csv file has been generated successfully!")