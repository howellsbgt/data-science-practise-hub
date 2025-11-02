import pandas as pd

class DataProcessor:

    def __init__(self, df):
        self.df = df

    def clean(self):
        #drop irrelevant rows
        self.df = self.df.dropna()
        return self.df
    
    def encode(self):
        #Convert categorical columns to numeric
        pass

