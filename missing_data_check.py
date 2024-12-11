import pandas as pd

# Load the dataset
file_path = '/Users/steve/Desktop/215/Final Report/Missing data check/Combined_Data_Set.csv'
data_with_missing = pd.read_csv(file_path)

# Identify locations of missing values
missing_locations = data_with_missing.isnull()

# Print the locations of missing values (column and row order)
print("Locations of Missing Values (Column and Row):")
for col in data_with_missing.columns:
    missing_rows = missing_locations[col][missing_locations[col]].index
    for row in missing_rows:
        print(f"Column: {col}, Row: {row}")
