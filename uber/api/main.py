import csv
import requests
from keep_alive import keep_alive

keep_alive()
# Your Mapbox API access token
MAPBOX_ACCESS_TOKEN = "pk.eyJ1Ijoic3VkYTIwMDEiLCJhIjoiY2xiemVxNnl5MTZqODN3cDM0amhjamEyaiJ9.Q6diHeYCJTNLIG7yBEec-Q"

# The name of the input CSV file containing the coordinates
INPUT_FILE = "joined_ride_data.csv"

# The name of the output CSV file to save the results to
OUTPUT_FILE = "addresses.csv"

# Function to reverse geocode a single coordinate and return the address
def get_address(lat, lon):
    # Make a request to the Mapbox API to reverse geocode the coordinate
    response = requests.get(f"https://api.mapbox.com/geocoding/v5/mapbox.places/{lon},{lat}.json", params={
        "access_token": MAPBOX_ACCESS_TOKEN
    })
    data = response.json()

    # Extract the address from the response
    address = data["features"][0]["place_name"]
    return address

# Open the output CSV file and read the addresses
# We'll use a dictionary to store the addresses, using the coordinates as the key
addresses = {}
with open(OUTPUT_FILE, "r", encoding='utf-8', errors='ignore') as f_out:
    reader = csv.DictReader(f_out)
    for row in reader:
        lat = row["lat"]
        lon = row["lon"]
        coordinates = f"{lat},{lon}"
        addresses[coordinates] = row["address"]

# Open the input CSV file and read the coordinates
with open(INPUT_FILE, "r") as f:
    reader = csv.DictReader(f)

    # Open the output CSV file in append mode
    # We'll use this to add new rows to the file without overwriting the existing content
    with open(OUTPUT_FILE, "a", encoding='utf-8', errors='ignore') as f_out:
        fieldnames = ["date/time", "lat", "lon", "base", "address"]
        writer = csv.DictWriter(f_out, fieldnames=fieldnames)

        # Iterate through the rows of the input CSV file
        for row in reader:
            # Check if the address for this coordinate has already been written to the output file
            lat = row["Lat"]
            lon = row["Lon"]
            coordinates = f"{lat},{lon}"
            if coordinates in addresses:
                # If the address has already been written, skip this coordinate
                continue

            # Reverse geocode the coordinate and write the result to the output CSV file
            address = get_address(row["Lat"], row["Lon"])
            writer.writerow({
            "date/time": row["Date/Time"],
            "lat": row["Lat"],
            "lon": row["Lon"],
            "base": row["Base"],
            "address": address
            })

            print("Completed")