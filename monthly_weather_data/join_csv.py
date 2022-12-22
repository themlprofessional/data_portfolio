import pandas as pd

# Load the first CSV file
df1 = pd.read_csv('april.csv')

# Load the second CSV file
df2 = pd.read_csv('may.csv')

# Load the third CSV file
df3 = pd.read_csv('june.csv')

# Load the fourth CSV file
df4 = pd.read_csv('july.csv')

# Join the dataframes using `concat`
result = pd.concat([df1, df2, df3, df4])

# Save the result to a new CSV file
result.to_csv('joined_weather_data.csv', index=False)
