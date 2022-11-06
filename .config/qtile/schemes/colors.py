import json

from utils import dir
from utils.settings import config

path = f'{dir.get()}/../tilix/schemes/Catppuccin-Mocha.json'

with open(path, 'r') as file:
  color = json.load(file)
  file.close()

