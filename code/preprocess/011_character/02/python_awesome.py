import os
from natto import MeCab
# bug of wordsを作成するためのライブラリ読み込み
from gensim import corpora, matutils

mc = MeCab()
txt_word_list = []

# テキストファイルを格納しているフォルダを読み込み
files = os.listdir(os.path.dirname(__file__)+'/path/txt')

# フォルダ配下のテキストファイルを1つずつ読み込み
for file in files:

  # テキストファイルから名詞と動詞の単語を取り出したリスト作成（Q11-1の処理と同じ）
  with open(os.path.dirname(__file__) + '/path/txt/'+file, 'r') as f:
    txt = f.read()
    word_list = []
    for n in mc.parse(txt, as_nodes=True):
      if not (n.is_bos() or n.is_eos()):
        part, word = n.feature.split(',', 1)
      if part == "名詞" or part == "動詞":
        word_list.append(n.surface)

  # テキストファイルごとの単語リストを追加
  txt_word_list.append(word_list)

# bug of wordsを作成するため全種類の単語を把握し、単語IDを付与した辞書を作成
corpus_dic = corpora.Dictionary(txt_word_list)

# 各文章の単語リストをコーパス（辞書の単語IDと単語の出現回数）リストに変換
corpus_list = [corpus_dic.doc2bow(word_in_text) for word_in_text in txt_word_list]

# コーパスリストをスパースマトリックス（csc型）に変換
word_matrix = matutils.corpus2csc(corpus_list)
