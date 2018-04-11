from preprocess.load_data.data_loader import load_hotel_reserve
customer_tb, hotel_tb, reserve_tb = load_hotel_reserve()

# 下の行から本書スタート
from sklearn.preprocessing import StandardScaler

# 少数点以下を扱えるようにするためfloat型に変換
reserve_tb['people_num'] = reserve_tb['people_num'].astype(float)

# 正規化を行うオブジェクトを生成
ss = StandardScaler()

# fit_transform関数は、fit関数（正規化するための前準備の計算）と
# transform関数（準備された情報から正規化の変換処理を行う）の両方を行う
result = ss.fit_transform(reserve_tb[['people_num', 'total_price']])

reserve_tb['people_num_normalized'] = [x[0] for x in result]
reserve_tb['total_price_normalized'] = [x[1] for x in result]
