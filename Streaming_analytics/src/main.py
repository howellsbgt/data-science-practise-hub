
from data_loader import DataLoader
from data_processor import DataProcessor

if __name__ == "__main__":
    loader = DataLoader("data/netflix_users.csv")
    df = loader.load()

    processor = DataProcessor(df)
    df = processor.clean()
    df = processor.encode()

