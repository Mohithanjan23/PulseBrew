from cryptography.fernet import Fernet
import os

KEY = os.getenv("ENCRYPTION_KEY")

if not KEY:
    raise RuntimeError("ENCRYPTION_KEY missing in environment variables")

fernet = Fernet(KEY.encode())

def encrypt_data(data: str) -> str:
    return fernet.encrypt(data.encode()).decode()

def decrypt_data(token: str) -> str:
    return fernet.decrypt(token.encode()).decode()
