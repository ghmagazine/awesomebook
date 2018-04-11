# MeCabをPythonで利用するためのライブラリ読み込み
import os
from natto import MeCab

# merosには、メロスの文章データが格納
# MeCabを実行するオブジェクトを生成
mc = MeCab()

# 下記のコードはテキスト時は、下記のようにする
with open(os.path.dirname(__file__) + '/path/txt/meros.txt', 'r') as f:
  txt = f.read()

word_list = []
# MeCabを用いて、形態素解析を実行
for part_and_word in mc.parse(txt, as_nodes=True):

  # 形態素解析結果のpart_and_wordが開始/終了オブジェクトでないことを判定
  if not (part_and_word.is_bos() or part_and_word.is_eos()):

    # 形態素解析結果から品詞と単語を取得
    part, word = part_and_word.feature.split(',', 1)

    # 名詞と動詞の単語を抽出
    if part == '名詞' or part == '動詞':
      word_list.append(part_and_word.surface)
