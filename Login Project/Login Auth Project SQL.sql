CREATE DATABASE Auth_System;
Use Auth_System;

CREATE TABLE roles (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE permissions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE role_permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_role_permissions PRIMARY KEY (role_id, permission_id),
    CONSTRAINT FK_role_permissions_role FOREIGN KEY (role_id)
        REFERENCES roles(id) ON DELETE CASCADE,
    CONSTRAINT FK_role_permissions_permission FOREIGN KEY (permission_id)
        REFERENCES permissions(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE login_log (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NULL,
    login_time DATETIME DEFAULT GETDATE(),
    success BIT NOT NULL,
    ip_address VARCHAR(45),
    user_agent VARCHAR(MAX),
    CONSTRAINT FK_login_log_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE SET NULL
);

-- Indexes for users table
CREATE NONCLUSTERED INDEX idx_users_username ON users(username);
CREATE NONCLUSTERED INDEX idx_users_email ON users(email);

-- Indexes for login_log table
CREATE NONCLUSTERED INDEX idx_login_log_user_id ON login_log(user_id);
CREATE NONCLUSTERED INDEX idx_login_log_time ON login_log(login_time);


--If you want to avoid duplicate inserts when the script runs multiple times, you can use a conditional check:
--This ensures the roles aren’t inserted multiple times.
IF NOT EXISTS (SELECT 1 FROM roles WHERE name = 'admin')
BEGIN
    INSERT INTO roles (name, description) VALUES
    ('admin', 'Administrator with full access'),
    ('user', 'Regular user with basic access'),
    ('moderator', 'Moderator with limited admin access');
END

--to make the script idempotent (safe to run multiple times), you can check for existing rows:
IF NOT EXISTS (SELECT 1 FROM permissions WHERE name = 'read_users')
BEGIN
    INSERT INTO permissions (name, description) VALUES
    ('read_users', 'Can view user list'),
    ('create_users', 'Can create new users'),
    ('update_users', 'Can update user information'),
    ('delete_users', 'Can delete users'),
    ('read_logs', 'Can view login logs'),
    ('manage_roles', 'Can manage roles and permissions'),
    ('access_admin', 'Can access admin panel');
END

-- Admin permissions
IF NOT EXISTS (SELECT 1 FROM role_permissions WHERE role_id = 1 AND permission_id = 1)
BEGIN
    INSERT INTO role_permissions (role_id, permission_id) VALUES
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7);
END

-- User permissions
IF NOT EXISTS (SELECT 1 FROM role_permissions WHERE role_id = 2 AND permission_id = 1)
BEGIN
    INSERT INTO role_permissions (role_id, permission_id) VALUES
    (2, 1);
END

-- Moderator permissions
IF NOT EXISTS (SELECT 1 FROM role_permissions WHERE role_id = 3 AND permission_id = 1)
BEGIN
    INSERT INTO role_permissions (role_id, permission_id) VALUES
    (3, 1), (3, 2), (3, 3), (3, 5);
END

select * from permissions;
select * from roles;
select * from role_permissions;


CREATE PROCEDURE sp_log_login
    @p_user_id INT,
    @p_success BIT,
    @p_ip_address VARCHAR(45),
    @p_user_agent VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO login_log (user_id, success, ip_address, user_agent)
    VALUES (@p_user_id, @p_success, @p_ip_address, @p_user_agent);

    -- Return the ID of the newly inserted row
    SELECT SCOPE_IDENTITY() AS log_id;
END;

/* To call procedure
EXEC sp_log_login
    @p_user_id = 1,
    @p_success = 1,
    @p_ip_address = '192.168.1.10',
    @p_user_agent = 'Mozilla/5.0';
	*/

CREATE PROCEDURE sp_get_user_permissions
    @p_user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT 
        p.id,
        p.name,
        p.description
    FROM permissions p
    INNER JOIN role_permissions rp 
        ON p.id = rp.permission_id
    INNER JOIN users u 
        ON u.role_id = rp.role_id
    WHERE u.id = @p_user_id 
      AND u.is_active = 1;
END;

/*
EXEC sp_get_user_permissions @p_user_id = 1;
*/

CREATE PROCEDURE sp_create_user
    @p_username       VARCHAR(50),
    @p_email          VARCHAR(100),
    @p_password_hash  VARCHAR(255),
    @p_role_id        INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO users (username, email, password_hash, role_id)
        VALUES (@p_username, @p_email, @p_password_hash, @p_role_id);

        -- Return newly created user ID
        SELECT SCOPE_IDENTITY() AS user_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback if error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Rethrow the original SQL Server error
        THROW;
    END CATCH
END;


/*
EXEC sp_create_user
    @p_username = 'john',
    @p_email = 'john@example.com',
    @p_password_hash = 'hashed_pw_here',
    @p_role_id = 2;
*/

-- With procedure inserted a user, now checking that user in users table
select * from users;
select * from login_log;