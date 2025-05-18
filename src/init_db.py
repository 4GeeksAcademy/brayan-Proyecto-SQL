import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# Load environment variables
load_dotenv()

# Read DB path from environment variable
DB_PATH = os.getenv('DB_PATH', './data/database.db')  # fallback to default
DB_URL = f'sqlite:///{DB_PATH}'

# Ensure the data directory exists
os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

# Create and populate the database
def initialize_database():
    try:
        engine = create_engine(DB_URL)

        with engine.begin() as connection:
            print("✅ Connected to SQLite database.")

            with open('./src/sql/create.sql', 'r') as f:
                create_sql = f.read()
                for stmt in create_sql.split(';'):
                    if stmt.strip():
                        connection.execute(text(stmt.strip()))
            print("🧱 Tables created successfully.")

            with open('./src/sql/insert.sql', 'r') as f:
                insert_sql = f.read()
                for stmt in insert_sql.split(';'):
                    if stmt.strip():
                        connection.execute(text(stmt.strip()))
            print("🌱 Data inserted successfully.")
    except Exception as e:
        print(f"❌ Initialization error: {e}")

if __name__ == '__main__':
    initialize_database()
    