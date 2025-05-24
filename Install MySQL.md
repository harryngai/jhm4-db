# MySQL 伺服器安裝和 Root 密碼配置

## 安裝命令

```bash
sudo apt-get update
sudo apt-get install -y mysql-server
sudo service mysql start
sudo mysql
```

## Root 密碼配置

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Test-1234';
```

這條 SQL 命令將 root 用戶的認證方式更改為 `mysql_native_password`，並將密碼設置為 `Test-1234`。


```bash
sudo mysql -u root -p
```