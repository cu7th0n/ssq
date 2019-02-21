{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "ssq.ipynb",
      "version": "0.3.2",
      "provenance": [],
      "collapsed_sections": [],
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "accelerator": "TPU"
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/cu7th0n/capstone/blob/master/ssq.ipynb\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "metadata": {
        "id": "RgLZyGViHwV9",
        "colab_type": "code",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 2040
        },
        "outputId": "123dbb64-8483-4049-d046-f665e4efda5f"
      },
      "cell_type": "code",
      "source": [
        "import requests\n",
        "from bs4 import BeautifulSoup\n",
        "import xlwt\n",
        "import time\n",
        "\n",
        "#获取第一页的内容\n",
        "def get_one_page(url):\n",
        "    headers = {\n",
        "        'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36'\n",
        "    }\n",
        "    response = requests.get(url,headers=headers)\n",
        "    if response.status_code == 200:\n",
        "        return response.text\n",
        "    return \n",
        "\n",
        "#解析第一页内容，数据结构化\n",
        "def parse_one_page(html):\n",
        "\n",
        "    soup = BeautifulSoup(html,'lxml')\n",
        "    i = 0\n",
        "    for item in soup.select('tr')[2:-1]:\n",
        "\n",
        "        yield{\n",
        "            'time':item.select('td')[i].text,\n",
        "            'digit_1':item.select('td em')[0].text,\n",
        "            'digit_2':item.select('td em')[1].text,\n",
        "            'digit_3':item.select('td em')[2].text,\n",
        "            'digit_4':item.select('td em')[3].text,\n",
        "            'digit_5':item.select('td em')[4].text,\n",
        "            'digit_6':item.select('td em')[5].text,\n",
        "            'digit_7':item.select('td em')[6].text,\n",
        "        }\n",
        "\n",
        "#将数据写入Excel表格中\n",
        "def write_to_excel():\n",
        "    f = xlwt.Workbook()                             \n",
        "    sheet1 = f.add_sheet('ssq',cell_overwrite_ok=True)\n",
        "    row0 = [\"date\",\"digit_1\",\"digit_2\",\"digit_3\",\"digit_4\",\"digit_5\",\"digit_6\",\"digit_7\"]\n",
        "    #写入第一行\n",
        "    for j in range(0,len(row0)):\n",
        "        sheet1.write(0,j,row0[j])\n",
        "\n",
        "    #依次爬取每一页内容的每一期信息，并将其依次写入Excel\n",
        "    i=0\n",
        "    for k in range(1,120):\n",
        "        url = 'http://kaijiang.zhcw.com/zhcw/html/ssq/list_%s.html' %(str(k))\n",
        "        html = get_one_page(url)\n",
        "        \n",
        "        #写入每一期的信息\n",
        "        for item in parse_one_page(html):\n",
        "            sheet1.write(i+1,0,item['time'])\n",
        "            sheet1.write(i+1,1,item['digit_1'])\n",
        "            sheet1.write(i+1,2,item['digit_2'])\n",
        "            sheet1.write(i+1,3,item['digit_3'])\n",
        "            sheet1.write(i+1,4,item['digit_4'])\n",
        "            sheet1.write(i+1,5,item['digit_5'])\n",
        "            sheet1.write(i+1,6,item['digit_6'])\n",
        "            sheet1.write(i+1,7,item['digit_7'])\n",
        "            i+=1\n",
        "    \n",
        "    f.save('ssq.xls')\n",
        "    print('%d页已保存。'%k)\n",
        "    \n",
        "def main():\n",
        "    write_to_excel()\n",
        "\n",
        "if __name__ == '__main__':\n",
        "    main()"
      ],
      "execution_count": 1,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "正在保存第1页。\n",
            "正在保存第2页。\n",
            "正在保存第3页。\n",
            "正在保存第4页。\n",
            "正在保存第5页。\n",
            "正在保存第6页。\n",
            "正在保存第7页。\n",
            "正在保存第8页。\n",
            "正在保存第9页。\n",
            "正在保存第10页。\n",
            "正在保存第11页。\n",
            "正在保存第12页。\n",
            "正在保存第13页。\n",
            "正在保存第14页。\n",
            "正在保存第15页。\n",
            "正在保存第16页。\n",
            "正在保存第17页。\n",
            "正在保存第18页。\n",
            "正在保存第19页。\n",
            "正在保存第20页。\n",
            "正在保存第21页。\n",
            "正在保存第22页。\n",
            "正在保存第23页。\n",
            "正在保存第24页。\n",
            "正在保存第25页。\n",
            "正在保存第26页。\n",
            "正在保存第27页。\n",
            "正在保存第28页。\n",
            "正在保存第29页。\n",
            "正在保存第30页。\n",
            "正在保存第31页。\n",
            "正在保存第32页。\n",
            "正在保存第33页。\n",
            "正在保存第34页。\n",
            "正在保存第35页。\n",
            "正在保存第36页。\n",
            "正在保存第37页。\n",
            "正在保存第38页。\n",
            "正在保存第39页。\n",
            "正在保存第40页。\n",
            "正在保存第41页。\n",
            "正在保存第42页。\n",
            "正在保存第43页。\n",
            "正在保存第44页。\n",
            "正在保存第45页。\n",
            "正在保存第46页。\n",
            "正在保存第47页。\n",
            "正在保存第48页。\n",
            "正在保存第49页。\n",
            "正在保存第50页。\n",
            "正在保存第51页。\n",
            "正在保存第52页。\n",
            "正在保存第53页。\n",
            "正在保存第54页。\n",
            "正在保存第55页。\n",
            "正在保存第56页。\n",
            "正在保存第57页。\n",
            "正在保存第58页。\n",
            "正在保存第59页。\n",
            "正在保存第60页。\n",
            "正在保存第61页。\n",
            "正在保存第62页。\n",
            "正在保存第63页。\n",
            "正在保存第64页。\n",
            "正在保存第65页。\n",
            "正在保存第66页。\n",
            "正在保存第67页。\n",
            "正在保存第68页。\n",
            "正在保存第69页。\n",
            "正在保存第70页。\n",
            "正在保存第71页。\n",
            "正在保存第72页。\n",
            "正在保存第73页。\n",
            "正在保存第74页。\n",
            "正在保存第75页。\n",
            "正在保存第76页。\n",
            "正在保存第77页。\n",
            "正在保存第78页。\n",
            "正在保存第79页。\n",
            "正在保存第80页。\n",
            "正在保存第81页。\n",
            "正在保存第82页。\n",
            "正在保存第83页。\n",
            "正在保存第84页。\n",
            "正在保存第85页。\n",
            "正在保存第86页。\n",
            "正在保存第87页。\n",
            "正在保存第88页。\n",
            "正在保存第89页。\n",
            "正在保存第90页。\n",
            "正在保存第91页。\n",
            "正在保存第92页。\n",
            "正在保存第93页。\n",
            "正在保存第94页。\n",
            "正在保存第95页。\n",
            "正在保存第96页。\n",
            "正在保存第97页。\n",
            "正在保存第98页。\n",
            "正在保存第99页。\n",
            "正在保存第100页。\n",
            "正在保存第101页。\n",
            "正在保存第102页。\n",
            "正在保存第103页。\n",
            "正在保存第104页。\n",
            "正在保存第105页。\n",
            "正在保存第106页。\n",
            "正在保存第107页。\n",
            "正在保存第108页。\n",
            "正在保存第109页。\n",
            "正在保存第110页。\n",
            "正在保存第111页。\n",
            "正在保存第112页。\n",
            "正在保存第113页。\n",
            "正在保存第114页。\n",
            "正在保存第115页。\n",
            "正在保存第116页。\n",
            "正在保存第117页。\n",
            "正在保存第118页。\n",
            "正在保存第119页。\n"
          ],
          "name": "stdout"
        }
      ]
    },
    {
      "metadata": {
        "id": "ZiuZJDx6mi45",
        "colab_type": "code",
        "colab": {}
      },
      "cell_type": "code",
      "source": [
        "import pandas as pd\n",
        "data = pd.read_excel('ssq.xls')\n",
        "\n",
        "data['date'] = pd.to_datetime(data['date'])\n",
        "data = data.sort_values(by = 'date')\n",
        "data.reset_index(inplace=True)\n",
        "del data['index']\n",
        "del data['date']"
      ],
      "execution_count": 0,
      "outputs": []
    },
    {
      "metadata": {
        "id": "aVqnjduWjv6r",
        "colab_type": "code",
        "outputId": "89b9224a-b110-4698-b472-ffc3a929b169",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 204
        }
      },
      "cell_type": "code",
      "source": [
        "data.head()"
      ],
      "execution_count": 3,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>digit_1</th>\n",
              "      <th>digit_2</th>\n",
              "      <th>digit_3</th>\n",
              "      <th>digit_4</th>\n",
              "      <th>digit_5</th>\n",
              "      <th>digit_6</th>\n",
              "      <th>digit_7</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <th>0</th>\n",
              "      <td>10</td>\n",
              "      <td>11</td>\n",
              "      <td>12</td>\n",
              "      <td>13</td>\n",
              "      <td>26</td>\n",
              "      <td>28</td>\n",
              "      <td>11</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>1</th>\n",
              "      <td>4</td>\n",
              "      <td>9</td>\n",
              "      <td>19</td>\n",
              "      <td>20</td>\n",
              "      <td>21</td>\n",
              "      <td>26</td>\n",
              "      <td>12</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>2</th>\n",
              "      <td>1</td>\n",
              "      <td>7</td>\n",
              "      <td>10</td>\n",
              "      <td>23</td>\n",
              "      <td>28</td>\n",
              "      <td>32</td>\n",
              "      <td>16</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>3</th>\n",
              "      <td>4</td>\n",
              "      <td>6</td>\n",
              "      <td>7</td>\n",
              "      <td>10</td>\n",
              "      <td>13</td>\n",
              "      <td>25</td>\n",
              "      <td>3</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>4</th>\n",
              "      <td>4</td>\n",
              "      <td>6</td>\n",
              "      <td>15</td>\n",
              "      <td>17</td>\n",
              "      <td>30</td>\n",
              "      <td>31</td>\n",
              "      <td>16</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   digit_1  digit_2  digit_3  digit_4  digit_5  digit_6  digit_7\n",
              "0       10       11       12       13       26       28       11\n",
              "1        4        9       19       20       21       26       12\n",
              "2        1        7       10       23       28       32       16\n",
              "3        4        6        7       10       13       25        3\n",
              "4        4        6       15       17       30       31       16"
            ]
          },
          "metadata": {
            "tags": []
          },
          "execution_count": 3
        }
      ]
    },
    {
      "metadata": {
        "id": "ujDFuZtgr6H-",
        "colab_type": "code",
        "colab": {}
      },
      "cell_type": "code",
      "source": [
        "D_1 = data['digit_1']\n",
        "D_2 = data['digit_2']\n",
        "D_3 = data['digit_3']\n",
        "D_4 = data['digit_4']\n",
        "D_5 = data['digit_5']\n",
        "D_6 = data['digit_6']\n",
        "D_7 = data['digit_7']"
      ],
      "execution_count": 0,
      "outputs": []
    },
    {
      "metadata": {
        "id": "WJ_cbVxk8csd",
        "colab_type": "code",
        "outputId": "f9bb3950-f968-470a-a472-215cb12f6cd2",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 34
        }
      },
      "cell_type": "code",
      "source": [
        "D_7.unique()"
      ],
      "execution_count": 5,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/plain": [
              "array([11, 12, 16,  3,  6,  7,  8,  9, 13, 15,  2,  4,  1, 14, 10,  5])"
            ]
          },
          "metadata": {
            "tags": []
          },
          "execution_count": 5
        }
      ]
    },
    {
      "metadata": {
        "id": "npbn5vaxnSI0",
        "colab_type": "code",
        "colab": {}
      },
      "cell_type": "code",
      "source": [
        "import numpy as np\n",
        "\n",
        "def create_interval_dataset(dataset, look_back):\n",
        "    \"\"\"\n",
        "    :param dataset: input array of time intervals\n",
        "    :param look_back: each training set feature length\n",
        "    :return: convert an array of values into a dataset matrix.\n",
        "    \"\"\"\n",
        "    dataX, dataY = [], []\n",
        "    for i in range(len(dataset) - look_back):\n",
        "        dataX.append(dataset[i:i+look_back])\n",
        "        dataY.append(dataset[i+look_back])\n",
        "    return np.asarray(dataX), np.asarray(dataY)\n"
      ],
      "execution_count": 0,
      "outputs": []
    },
    {
      "metadata": {
        "id": "_Sh7W95znabX",
        "colab_type": "code",
        "colab": {}
      },
      "cell_type": "code",
      "source": [
        "def train_model(train_set,mname,look_back = 200,data_dim = 34,batch_size = 1):\n",
        "  from keras.utils import to_categorical\n",
        "  from keras.models import Sequential\n",
        "  from keras.layers import LSTM, Dense, Dropout\n",
        "  import numpy as np\n",
        "\n",
        "  timesteps = look_back\n",
        " \n",
        "  # Expected input batch shape: (batch_size, timesteps, data_dim)\n",
        "  # Note that we have to provide the full batch_input_shape since the network is stateful.\n",
        "  # the sample of index i in batch k is the follow-up for the sample i in batch k-1.\n",
        "  model = Sequential()\n",
        "  model.add(LSTM(data_dim, return_sequences=True, stateful=True,\n",
        "               batch_input_shape=(batch_size, timesteps, data_dim)))\n",
        "  model.add(LSTM(data_dim*2, return_sequences=True, stateful=True))\n",
        "  model.add(Dropout(0.2))\n",
        "  model.add(LSTM(data_dim*4, return_sequences=True, stateful=True))\n",
        "  model.add(Dropout(0.2))\n",
        "  model.add(LSTM(data_dim*8, stateful=True))\n",
        "  model.add(Dense(data_dim, activation='softmax'))\n",
        "\n",
        "  model.compile(loss='categorical_crossentropy',\n",
        "              optimizer='rmsprop',\n",
        "              metrics=['accuracy'])\n",
        "\n",
        "  df = to_categorical(train_set,data_dim)\n",
        "  \n",
        "  dataX, dataY = create_interval_dataset(df, look_back) \n",
        "  \n",
        "  total = len(train_set)\n",
        "  split = total*8//10\n",
        "\n",
        "  X_train = dataX[:split]\n",
        "  y_train = dataY[:split]\n",
        "\n",
        "  X_val = dataX[split+1:total-1]\n",
        "  y_val = dataY[split+1:total-1]\n",
        "  \n",
        "  model.fit(X_train, y_train,batch_size=batch_size, epochs=1,\n",
        "            shuffle=False,validation_data=(X_val, y_val))\n",
        "  model.save(mname)\n"
      ],
      "execution_count": 0,
      "outputs": []
    },
    {
      "metadata": {
        "id": "jsnoFFBpmEgY",
        "colab_type": "code",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 374
        },
        "outputId": "036d13e6-12d1-47bc-975d-9cf44f99417d"
      },
      "cell_type": "code",
      "source": [
        "models = ['M1_model.h5', 'M2_model.h5', 'M3_model.h5',\n",
        "          'M4_model.h5', 'M5_model.h5','M6_model.h5','M7_model.h5']\n",
        "tdatas = [D_1, D_2, D_3, D_4, D_5, D_6, D_7]\n",
        "\n",
        "for (model,tdata) in zip(models,tdatas):\n",
        "  train_model(tdata,model)"
      ],
      "execution_count": 14,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 714s 376ms/step - loss: 2.5786 - acc: 0.1714 - val_loss: 2.5068 - val_acc: 0.2218\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 756s 397ms/step - loss: 3.0275 - acc: 0.0810 - val_loss: 2.9569 - val_acc: 0.0582\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 729s 383ms/step - loss: 3.1611 - acc: 0.0589 - val_loss: 3.1279 - val_acc: 0.0582\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 940s 494ms/step - loss: 3.1977 - acc: 0.0610 - val_loss: 3.0841 - val_acc: 0.0836\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 720s 379ms/step - loss: 3.2494 - acc: 0.0662 - val_loss: 3.0137 - val_acc: 0.0618\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 717s 377ms/step - loss: 2.6730 - acc: 0.1404 - val_loss: 2.6827 - val_acc: 0.1455\n",
            "Train on 1902 samples, validate on 275 samples\n",
            "Epoch 1/1\n",
            "1902/1902 [==============================] - 1017s 535ms/step - loss: 2.9239 - acc: 0.0736 - val_loss: 2.9039 - val_acc: 0.0764\n"
          ],
          "name": "stdout"
        }
      ]
    },
    {
      "metadata": {
        "id": "qIIZ6jAIgcJI",
        "colab_type": "code",
        "outputId": "a4062f86-3e0f-4201-e8ad-f92a1ebf7da6",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 627
        }
      },
      "cell_type": "code",
      "source": [
        "from keras.models import load_model\n",
        "from keras.utils import to_categorical\n",
        "models = ['M1_model.h5', 'M2_model.h5', 'M3_model.h5', 'M4_model.h5', 'M5_model.h5','M6_model.h5','M7_model.h5']\n",
        "tdatas = [D_1,D_2,D_3,D_4,D_5,D_6,D_7]\n",
        "\n",
        "for (model,tdata) in zip(models,tdatas):\n",
        "  print(model)\n",
        "  M_ssq = load_model(model)\n",
        "\n",
        "  df = to_categorical(tdata,num_classes=34) \n",
        "  dataX, dataY = create_interval_dataset(df, look_back=200)\n",
        "\n",
        "  pred = M_ssq.predict(dataX[-1:])\n",
        "  print(max(pred[0]))\n",
        "  print(np.argmax(pred))\n",
        "  print('_____________________________')"
      ],
      "execution_count": 21,
      "outputs": [
        {
          "output_type": "stream",
          "text": [
            "M1_model.h5\n"
          ],
          "name": "stdout"
        },
        {
          "output_type": "error",
          "ename": "ValueError",
          "evalue": "ignored",
          "traceback": [
            "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
            "\u001b[0;31mValueError\u001b[0m                                Traceback (most recent call last)",
            "\u001b[0;32m<ipython-input-21-ed2b23f3f0e0>\u001b[0m in \u001b[0;36m<module>\u001b[0;34m()\u001b[0m\n\u001b[1;32m     11\u001b[0m   \u001b[0;31m#dataX, dataY = create_interval_dataset(df, look_back=200)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     12\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m---> 13\u001b[0;31m   \u001b[0mpred\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mM_ssq\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mpredict\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0mdf\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;34m-\u001b[0m\u001b[0;36m200\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m     14\u001b[0m   \u001b[0mprint\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mmax\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mpred\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m     15\u001b[0m   \u001b[0mprint\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mnp\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0margmax\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mpred\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;32m/usr/local/lib/python3.6/dist-packages/keras/engine/training.py\u001b[0m in \u001b[0;36mpredict\u001b[0;34m(self, x, batch_size, verbose, steps)\u001b[0m\n\u001b[1;32m   1147\u001b[0m                              'argument.')\n\u001b[1;32m   1148\u001b[0m         \u001b[0;31m# Validate user data.\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m-> 1149\u001b[0;31m         \u001b[0mx\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0m_\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0m_\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0m_standardize_user_data\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mx\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m   1150\u001b[0m         \u001b[0;32mif\u001b[0m \u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mstateful\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m   1151\u001b[0m             \u001b[0;32mif\u001b[0m \u001b[0mx\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mshape\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m]\u001b[0m \u001b[0;34m>\u001b[0m \u001b[0mbatch_size\u001b[0m \u001b[0;32mand\u001b[0m \u001b[0mx\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mshape\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m0\u001b[0m\u001b[0;34m]\u001b[0m \u001b[0;34m%\u001b[0m \u001b[0mbatch_size\u001b[0m \u001b[0;34m!=\u001b[0m \u001b[0;36m0\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;32m/usr/local/lib/python3.6/dist-packages/keras/engine/training.py\u001b[0m in \u001b[0;36m_standardize_user_data\u001b[0;34m(self, x, y, sample_weight, class_weight, check_array_lengths, batch_size)\u001b[0m\n\u001b[1;32m    749\u001b[0m             \u001b[0mfeed_input_shapes\u001b[0m\u001b[0;34m,\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    750\u001b[0m             \u001b[0mcheck_batch_axis\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;32mFalse\u001b[0m\u001b[0;34m,\u001b[0m  \u001b[0;31m# Don't enforce the batch size.\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 751\u001b[0;31m             exception_prefix='input')\n\u001b[0m\u001b[1;32m    752\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    753\u001b[0m         \u001b[0;32mif\u001b[0m \u001b[0my\u001b[0m \u001b[0;32mis\u001b[0m \u001b[0;32mnot\u001b[0m \u001b[0;32mNone\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;32m/usr/local/lib/python3.6/dist-packages/keras/engine/training_utils.py\u001b[0m in \u001b[0;36mstandardize_input_data\u001b[0;34m(data, names, shapes, check_batch_axis, exception_prefix)\u001b[0m\n\u001b[1;32m    126\u001b[0m                         \u001b[0;34m': expected '\u001b[0m \u001b[0;34m+\u001b[0m \u001b[0mnames\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0mi\u001b[0m\u001b[0;34m]\u001b[0m \u001b[0;34m+\u001b[0m \u001b[0;34m' to have '\u001b[0m \u001b[0;34m+\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    127\u001b[0m                         \u001b[0mstr\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mlen\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mshape\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m)\u001b[0m \u001b[0;34m+\u001b[0m \u001b[0;34m' dimensions, but got array '\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 128\u001b[0;31m                         'with shape ' + str(data_shape))\n\u001b[0m\u001b[1;32m    129\u001b[0m                 \u001b[0;32mif\u001b[0m \u001b[0;32mnot\u001b[0m \u001b[0mcheck_batch_axis\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    130\u001b[0m                     \u001b[0mdata_shape\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mdata_shape\u001b[0m\u001b[0;34m[\u001b[0m\u001b[0;36m1\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m]\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;31mValueError\u001b[0m: Error when checking input: expected lstm_21_input to have 3 dimensions, but got array with shape (200, 34)"
          ]
        }
      ]
    }
  ]
}
