DROP DATABASE IF EXISTS passwords;
CREATE DATABASE passwords DEFAULT CHARACTER SET utf8mb4;
USE passwords;

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 512));
SET @init_vector = RANDOM_BYTES(16);

CREATE TABLE IF NOT EXISTS password_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    website VARCHAR(255) NOT NULL,
    link VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    pw VARBINARY(255) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert entries into the password_entries table
INSERT INTO password_entries (website, link, first_name, last_name, username, email, pw, comment) VALUES
    ('Google', 'https://google.com', 'Alice', 'Smith', 'alicesmith', 'alice.smith@example.com', AES_ENCRYPT('password123', @key_str, @init_vector), 'Personal account'),
    ('Facebook', 'https://facebook.com', 'Bob', 'Johnson', 'bobjohnson', 'bob.johnson@example.com', AES_ENCRYPT('mysecret', @key_str, @init_vector), 'Social media'),
    ('Twitter', 'https://twitter.com', 'Charlie', 'Brown', 'charliebrown', 'charlie.brown@example.com', AES_ENCRYPT('tweetlife', @key_str, @init_vector), 'Microblogging'),
    ('Instagram', 'https://instagram.com', 'Daisy', 'Miller', 'daisymiller', 'daisy.miller@example.com', AES_ENCRYPT('insta2024', @key_str, @init_vector), 'Photo sharing'),
    ('LinkedIn', 'https://linkedin.com', 'Ethan', 'Wilson', 'ethanwilson', 'ethan.wilson@example.com', AES_ENCRYPT('jobseeker', @key_str, @init_vector), 'Professional networking'),
    ('YouTube', 'https://youtube.com', 'Fiona', 'Davis', 'fionadavis', 'fiona.davis@example.com', AES_ENCRYPT('video123', @key_str, @init_vector), 'Video sharing platform'),
    ('Reddit', 'https://reddit.com', 'George', 'Garcia', 'georgegarcia', 'george.garcia@example.com', AES_ENCRYPT('subreddit', @key_str, @init_vector), 'Discussion forum'),
    ('Amazon', 'https://amazon.com', 'Hannah', 'Martinez', 'hannahmartinez', 'hannah.martinez@example.com', AES_ENCRYPT('shopaholic', @key_str, @init_vector), 'E-commerce'),
    ('Spotify', 'https://spotify.com', 'Isaac', 'Rodriguez', 'isaacrodriguez', 'isaac.rodriguez@example.com', AES_ENCRYPT('musiclover', @key_str, @init_vector), 'Music streaming'),
    ('Netflix', 'https://netflix.com', 'Jack', 'Hernandez', 'jackhernandez', 'jack.hernandez@example.com', AES_ENCRYPT('watchingmovies', @key_str, @init_vector), 'Streaming service');
