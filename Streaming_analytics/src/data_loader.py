import pandas as pd

class DataLoader:
    
    def __init__(self, filepath):
        self.filepath = filepath

    def load(self):
        df = pd.read_csv(self.filepath)
        print(f'Loaded {df.shape[0]} rows')
        return df
