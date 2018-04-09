import pandas as pd

# 下の行から本書スタート
# データ型の確認
type(40000 / 3)

# 整数型へ変換
int(40000 / 3)

# 浮動小数点型へ変換
float(40000 / 3)

df = pd.DataFrame({'value': [40000 / 3]})

# データ型の確認
df.dtypes

# 整数型へ変換
df['value'].astype('int8')
df['value'].astype('int16')
df['value'].astype('int32')
df['value'].astype('int64')

# 浮動小数点型へ変換
df['value'].astype('float16')
df['value'].astype('float32')
df['value'].astype('float64')
df['value'].astype('float128')

# 下記のようにpythonのデータ型を指定できる
df['value'].astype(int)
df['value'].astype(float)
