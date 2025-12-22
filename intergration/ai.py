import os
import requests
from dotenv import load_dotenv
import json

load_dotenv()

AI_API_KEY = os.getenv('AI_API_KEY')
AI_MODEL = os.getenv('AI_MODEL', 'your-neurogrid-model')
CACHE_FILE = 'ai_cache.json'

def load_cache():
    try:
        with open(CACHE_FILE) as f:
            return json.load(f)
    except FileNotFoundError:
        return {}

def save_cache(cache):
    with open(CACHE_FILE, 'w') as f:
        json.dump(cache, f)

def get_inference(data):
    if not data:
        return {'error': 'No data provided'}

    cache = load_cache()
    key = data.lower().strip()

    if key in cache:
        return cache[key]

    headers = {'Authorization': f'Bearer {AI_API_KEY}'}
    payload = {'inputs': data}

    try:
        response = requests.post(f'https://api-inference.huggingface.co/models/{AI_MODEL}', json=payload, headers=headers, timeout=10)
        response.raise_for_status()
        result = response.json()
        cache[key] = result
        save_cache(cache)
        return result
    except Exception as e:
        return {'error': str(e)}

if __name__ == '__main__':
    print(json.dumps(get_inference("post-op recovery state"), indent=2))
