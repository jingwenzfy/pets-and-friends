import pandas as pd

# Load the dataset
file_path = 'file location'
data_with_missing = pd.read_csv(file_path)

# Identify locations of missing values
missing_locations = data_with_missing.isnull()

# Print the locations of missing values (row number and column name)
print("Locations of missing values (Row and Column):")
for row_idx, col in missing_locations.stack()[lambda x: x].index:
    print(f"Row: {row_idx}, Column: {col}")
