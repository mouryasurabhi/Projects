# -*- coding: utf-8 -*-
"""
Created on Sun Mar  8 18:39:03 2020

@author: 91970
"""

import scipy.io
import numpy as np
import argparse

def nytdata_generator(outdir="C:/Users/91970/Documents/MASTERS/YEAR 2/PROJECT/LDA/data/"):
	mat = scipy.io.loadmat('C:/Users/91970/Documents/MASTERS/YEAR 2/PROJECT/LDA/data/nyt_data.mat')

	word_id = np.array([i[0].ravel()-1 for i in mat['Xid'].ravel()]) # matlab index starting from 1
	word_count = np.array([i[0].ravel() for i in mat['Xcnt'].ravel()])
	vocabulary = np.array([i[0][0] for i in mat['nyt_vocab']])

	D = len(word_count)
	vocab_size = len(vocabulary)
	print('number of documents:',D)
	print('vocabulary size:',vocab_size)

	# generate word count matrix of corpus, doc_cnt.shape = vocab_size, D
	wordcnt_mat = np.zeros((vocab_size,D))
	for d in range(D):
		wordcnt_mat[word_id[d],d] = word_count[d]

	np.save(outdir+'nytdata_mat.npy', wordcnt_mat)
	np.save(outdir+'nytdata_voc.npy', vocabulary)
	print('The generated nyt data is sucessfully saved in {}'.format(outdir))


