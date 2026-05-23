-- V8: Widen profile_image to TEXT for base64 data URL storage
ALTER TABLE CUSTOMER ALTER COLUMN profile_image SET DATA TYPE TEXT;
