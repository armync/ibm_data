SET @key_str = SHA2('My secret passphrase', 512);

SELECT * FROM customers LIMIT 5;

ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

UPDATE customers SET addressLine1  = AES_ENCRYPT(addressLine1 , @key_str);

SELECT * FROM customers LIMIT 5;

SELECT cast(AES_DECRYPT(addressLine1 , @key_str) as char(255)) FROM customers;