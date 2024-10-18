SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('firetrucks!', 512));

-- filler entry
SET @new_website = 'NewSite';
SET @new_link = 'https://newsite.com';
SET @new_first_name = 'John';
SET @new_last_name = 'Doe';
SET @new_username = 'johndoe';
SET @new_email = 'john.doe@example.com';
SET @new_pw = AES_ENCRYPT('newpassword', @key_str);
SET @new_comment = 'A new entry';

INSERT INTO password_entries (website, link, first_name, last_name, username, email, pw, comment)
VALUES (@new_website, @new_link, @new_first_name, @new_last_name, @new_username, @new_email, @new_pw, @new_comment);

-- Get the password with URL
SET @search_link = 'https://google.com';
SELECT AES_DECRYPT(pw, @key_str) AS decrypted_password
FROM password_entries
WHERE link = @search_link;

-- Get entries with HTTPS
SELECT website, link, first_name, last_name, username, AES_DECRYPT(pw, @key_str) AS decrypted_password, comment
FROM password_entries
WHERE link LIKE 'https://%';

-- Change the URL using password
SET @old_link = 'https://google.com';
SET @new_link = 'https://google-new.com';
UPDATE password_entries
SET link = @new_link
WHERE link = @old_link;

-- Change password for username
SET @username_to_change = 'johndoe';
SET @new_password = AES_ENCRYPT('updatedpassword', @key_str);
UPDATE password_entries
SET pw = @new_password
WHERE username = @username_to_change;

-- Remove an entry based w/ URL
SET @link_to_remove = 'https://google-new.com';
DELETE FROM password_entries
WHERE link = @link_to_remove;

-- Remove an entry w/ password
SET @password_to_remove = AES_ENCRYPT('updatedpassword', @key_str);
DELETE FROM password_entries
WHERE pw = @password_to_remove;
