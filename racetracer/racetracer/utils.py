import yaml
import os
from pathlib import Path

# Define the path to the YAML file
BASE_DIR = Path(__file__).resolve().parent.parent
CONSTANTS_PATH = os.path.join(BASE_DIR, 'config.yaml')

def load_constants():
    with open(CONSTANTS_PATH, 'r') as file:
        return yaml.safe_load(file)

# Load the constants at the module level
CONSTANTS = load_constants()

# Accessing individual constants
git_config = CONSTANTS.get('git', {})
oauth_config = CONSTANTS.get('oauth', {})
gitlab_config = CONSTANTS.get('gitlab', {}) 
general = CONSTANTS