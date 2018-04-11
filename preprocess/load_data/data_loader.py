import pandas as pd
import os


def load_hotel_reserve():
  customer_tb = pd.read_csv(os.path.dirname(__file__)+'/../../data/customer.csv')
  hotel_tb = pd.read_csv(os.path.dirname(__file__) + '/../../data/hotel.csv')
  reserve_tb = pd.read_csv(os.path.dirname(__file__) + '/../../data/reserve.csv')
  return customer_tb, hotel_tb, reserve_tb


def load_holiday_mst():
  holiday_tb = pd.read_csv(os.path.dirname(__file__)+'/../../data/holiday_mst.csv',
                           index_col=False)
  return holiday_tb


def load_production():
  production_tb = pd.read_csv(os.path.dirname(__file__)+'/../../data/production.csv')
  return production_tb


def load_production_missing_num():
  production_tb = pd.read_csv(os.path.dirname(__file__)+'/../../data/production_missing_num.csv')
  return production_tb


def load_production_missing_category():
  production_tb = pd.read_csv(os.path.dirname(__file__)+'/../../data/production_missing_category.csv')
  return production_tb


def load_monthly_index():
  monthly_index_tb = \
    pd.read_csv(os.path.dirname(__file__)+'/../../data/monthly_index.csv')
  return monthly_index_tb


def load_meros_txt():
  with open(os.path.dirname(__file__)+'/../../data/txt/meros.txt', 'r') as f:
    meros = f.read()
    f.close()
  return meros
