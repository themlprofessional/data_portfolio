import pandas as pd

# Read the CSV file
df = pd.read_csv('My Uber Drives - 2016.csv')

# Find unique values from the PURPOSE column
unique_purpose = df['PURPOSE'].unique()

# Print the unique values
print(unique_purpose)
