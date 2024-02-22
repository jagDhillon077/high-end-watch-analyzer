import requests
from bs4 import BeautifulSoup

res = requests.get("https://www.chrono24.ca/rolex/submariner--mod1.htm")

soup = BeautifulSoup(res.text, 'html.parser')


print(res.text)


