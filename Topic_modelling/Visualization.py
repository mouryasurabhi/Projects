# -*- coding: utf-8 -*-
"""
Created on Sun Mar  8 18:41:02 2020

@author: 91970
"""
import numpy as np

def viz(gamma, vocab, topk=20):
    sorted_idx = np.argsort(-gamma, axis=0)
    sorted_gamma = -np.sort(-gamma, axis=0)
    sorted_gamma /= np.sum(sorted_gamma, axis=0)
    _,topic_num = gamma.shape
    for i in range(topic_num):
        print('topic %i:'%(i+1))
        print('top-%i key words:\n'%topk, vocab[sorted_idx[:topk,i]])
        print('distribution of top-%i key words:\n'%topk,sorted_gamma[:topk,i])