import os

with open("/app/env.txt", 'w') as file:
    for key, value in os.environ.items():
        file.write(f'{key}={value}\n')
