# Magento auto installation

Repository for installing Magento with a bash installation script.

[![Screenshot-2020-05-27-e-Commerce-Platforms-Best-e-Commerce-Software-for-Selling-Online-Magento.png](https://i.postimg.cc/XJkR2zyr/Screenshot-2020-05-27-e-Commerce-Platforms-Best-e-Commerce-Software-for-Selling-Online-Magento.png)](https://postimg.cc/47n2ywPG)

[![Peek-2020-05-27-16-07.gif](https://i.postimg.cc/9fDRsyfP/Peek-2020-05-27-16-07.gif)](https://postimg.cc/v1dZVgfD)


## Setup/Usage/How To

#### 1. git clone the repository.
#### 2. sudo chmod 755 ./Magento_install.sh
`sudo chmod 755 ./Magento_install.sh`
#### 3. sudo -u $USER ./Magento_install.sh
`sudo -u $USER ./Magento_install.sh`

Easy guessable users and passwords are used, please check the script and change it in order to make it secure. The folder where Magento is installed in elegant, you can change it in order to make more accessible.

Made by Guillermo Zaandam


### Issues

`SQLSTATE[HY000] [1698] Access denied for user 'root'@'localhost'`

https://stackoverflow.com/questions/36864206/sqlstatehy000-1698-access-denied-for-user-rootlocalhost

