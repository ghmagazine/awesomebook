from natto import MeCab
import os
from gensim import corpora

mc = MeCab()

txt_list = []
files = os.listdir(os.path.dirname(__file__)+'/path/txt')
for file in files:
    with open(os.path.dirname(__file__) + '/path/txt/'+file, 'r') as f:
        txt = f.read()
        word_list = []
        for n in mc.parse(txt, as_nodes=True):
            if not (n.is_bos() or n.is_eos()):
                part, word = n.feature.split(',', 1)
                if part == "名詞" or part == "動詞":
                    word_list.append(n.surface)
        txt_list.append(word_list)

dictionary = corpora.Dictionary(txt_list)
corpus_list = [dictionary.doc2bow(txt) for txt in txt_list]

# 下の行から本書スタート
from gensim import matutils, models

# corpus_listを準備するコードは省略

# TF-IDFのモデルを生成
tfidf_model = models.TfidfModel(corpus_list, normalize=True)

# corpusにTF-IDFを適用
corpus_list_tfidf = tfidf_model[corpus_list]
word_matrix = matutils.corpus2csc(corpus_list_tfidf)

