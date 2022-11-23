TRUNCATE Roles CASCADE;
TRUNCATE Users CASCADE;
TRUNCATE Logs CASCADE;
TRUNCATE AuthUser CASCADE;


DO $$
DECLARE
    defaultRole uuid = uuid_generate_v4();
    adminRole uuid = uuid_generate_v4();

    pudgeUser uuid = uuid_generate_v4();
    adminUser uuid = uuid_generate_v4();
    theboatmanUser uuid = uuid_generate_v4();
    kekUser uuid = uuid_generate_v4();
    lolUser uuid = uuid_generate_v4();
    
BEGIN
    INSERT INTO Roles(RoleName_, RoleId)
	values('default', defaultRole);

    INSERT INTO Roles(RoleName_, RoleId)
        values('admin', adminRole);

    INSERT INTO Users(UserId, RoleId, Name_, IsBanned_)
        values(pudgeUser, defaultRole, 'Pudge', FALSE);
    
    INSERT INTO Users(UserId, RoleId, Name_, IsBanned_)
        values(adminUser, adminRole, 'admin', FALSE);

    INSERT INTO Users(UserId, RoleId, Name_, IsBanned_)
        values(theboatmanUser, defaultRole, 'theboatman', FALSE);

    INSERT INTO Users(UserId, RoleId, Name_, IsBanned_)
        values(kekUser, defaultRole, 'Kek', TRUE);

    INSERT INTO Users(UserId, RoleId, Name_, IsBanned_)
        values(lolUser, defaultRole, 'Lol', TRUE);

    INSERT INTO AuthUser(AuthUserId, PasswordHash_)
        values(theboatmanUser, 'qwerty');

    INSERT INTO AuthUser(AuthUserId, PasswordHash_)
        values(adminUser, 'admin');

    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), theboatmanUser, 'Log1');
    
    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), theboatmanUser, 'Log2');
    
    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), theboatmanUser, 'Log3');
    

    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), pudgeUser, 'Log1');
    
    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), pudgeUser, 'Log2');
    
    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), pudgeUser, 'Log3');

    INSERT INTO Logs(LogId, UserId, Data_)
        values(uuid_generate_v4(), lolUser, 'Log1');
    
END $$;
