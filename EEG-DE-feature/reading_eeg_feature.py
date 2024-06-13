import os
import numpy as np 
import pickle 

## for features extracted with 1-second sliding window 
feature_1s_dir = './eeg_used_1s/'
file_1s_list = os.listdir(feature_1s_dir)
file_1s_list.sort()

for item in file_1s_list:
    print('*'*50)
    print(item)
    npz_data = np.load( os.path.join(feature_1s_dir, item) )
    print(list(npz_data.keys()))  # train_data, test_data, train_label, test_label 
    # train_data : samples from the first 9 movie clips
    data = pickle.loads(npz_data['train_data'])
    print(data.keys())
    for kk in list(data.keys()):
        print(data[kk].shape)
    # test_data : samples from the rest 6 movie clips
    data = pickle.loads(npz_data['test_data'])
    print(data.keys())
    for kk in list(data.keys()):
        print(data[kk].shape)
    # train_label
    data = npz_data['train_label']
    print(data.shape)
    # test_label
    data = npz_data['test_label']
    print(data.shape)
    print('*'*50 + '\n')



## for features extracted with 4-second sliding window 
feature_4s_dir = './eeg_used_4s/'
file_4s_list = os.listdir(feature_4s_dir)
file_4s_list.sort()

for item in file_4s_list:
    print('*'*50)
    print(item)
    npz_data = np.load( os.path.join(feature_4s_dir, item) )
    print(list(npz_data.keys()))  # train_data, test_data, train_label, test_label 
    # train_data : samples from the first 9 movie clips
    data = pickle.loads(npz_data['train_data'])
    print(data.keys())
    for kk in list(data.keys()):
        print(data[kk].shape)
    # test_data : samples from the rest 6 movie clips
    data = pickle.loads(npz_data['test_data'])
    print(data.keys())
    for kk in list(data.keys()):
        print(data[kk].shape)
    # train_label
    data = npz_data['train_label']
    print(data.shape)
    # test_label
    data = npz_data['test_label']
    print(data.shape)
    print('*'*50 + '\n')