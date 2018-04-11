from preprocess.load_data.data_loader import load_hotel_reserve
import pandas as pd
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
# sexがmanのときにTRUEとするブール型を追加
# このコードは、as.type関数を利用しなくてもブール型に変換
customer_tb[['sex_is_man']] = (customer_tb[['sex']] == 'man').astype('bool')

# sexをカテゴリ型に変換
customer_tb['sex_c'] = \
  pd.Categorical(customer_tb['sex'], categories=['man', 'woman'])

# astype関数でも変換可能
# customer_tb['sex_c'] = customer_tb['sex_c'].astype('category')

# インデックスデータはcodesに格納されている
customer_tb['sex_c'].cat.codes

# マスタデータはcategoriesに格納されている
customer_tb['sex_c'].cat.categories
