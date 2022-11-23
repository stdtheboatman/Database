DROP TABLE IF EXISTS Roles CASCADE;
DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS AuthUser CASCADE;
DROP TABLE IF EXISTS Logs CASCADE;
DROP TABLE IF EXISTS Profiles CASCADE;
DROP TABLE IF EXISTS Stream CASCADE;
DROP TABLE IF EXISTS StreamViewers CASCADE;
DROP TABLE IF EXISTS Chat CASCADE;
DROP TABLE IF EXISTS ChatModeratorsUsers CASCADE;
DROP TABLE IF EXISTS ChatBannedUsers CASCADE;
DROP TABLE IF EXISTS Messages CASCADE;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS Roles(
    RoleName_    varchar(16),
    RoleId uuid DEFAULT uuid_generate_v4(),

    PRIMARY KEY (RoleId)
);

CREATE TABLE IF NOT EXISTS Users(
    UserId  uuid    DEFAULT uuid_generate_v4(),
    Name_    varchar(16),
    RoleId  uuid,
    IsBanned_    boolean,

    PRIMARY KEY (UserId),

    CONSTRAINT fk_Roles
      FOREIGN KEY(RoleId) 
	    REFERENCES Roles(RoleId)
	    ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Logs(
    LogId uuid  DEFAULT uuid_generate_v4(),
    UserId uuid,
    Data_    varchar(128),
    TimeStamp_ TimeStamp     DEFAULT NOW(),

    PRIMARY KEY (LogId),

    CONSTRAINT fk_Logs
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS AuthUser(
    AuthUserId  uuid REFERENCES Users(UserId) ON DELETE CASCADE,
    PasswordHash_ varchar(64),

    PRIMARY KEY (AuthUserId)
);

CREATE TABLE IF NOT EXISTS Profiles(
    ProfileId  uuid REFERENCES Users(UserId) ON DELETE CASCADE,
    AvatarUrl_   varchar(64),
    Description_    varchar(256),

    PRIMARY KEY (ProfileId),
);

CREATE TABLE IF NOT EXISTS Stream(
    StreamId  uuid    DEFAULT uuid_generate_v4(),
    UserId  uuid,
    Url_ varchar(64),

    PRIMARY KEY (StreamId),

    CONSTRAINT fk_Users
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS StreamViewers(
    StreamId  uuid,
    UserId  uuid,

    PRIMARY KEY (StreamId, UserId),

    CONSTRAINT fk_Users
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE CASCADE,

    CONSTRAINT fk_Stream
      FOREIGN KEY(StreamId) 
	    REFERENCES Stream(StreamId)
	    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Chat(
    ChatId  uuid REFERENCES Stream(StreamId) ON DELETE CASCADE,
    IsReadOnly  boolean,

    PRIMARY KEY (ChatId)
);

CREATE TABLE IF NOT EXISTS ChatModeratorsUsers(
    ChatId  uuid,
    UserId  uuid,

    PRIMARY KEY (ChatId, UserId),

    CONSTRAINT fk_Users
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE CASCADE,

    CONSTRAINT fk_Chat
      FOREIGN KEY(ChatId) 
	    REFERENCES Chat(ChatId)
	    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ChatBannedUsers(
    ChatId  uuid,
    UserId  uuid,

    PRIMARY KEY (ChatId, UserId),

    CONSTRAINT fk_Users
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE CASCADE,

    CONSTRAINT fk_Chat
      FOREIGN KEY(ChatId) 
	    REFERENCES Chat(ChatId)
	    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Messages(
    MessageId  uuid    DEFAULT uuid_generate_v4(),
    ChatId  uuid,
    UserId  uuid,
    TimeStamp_  TimeStamp   DEFAULT NOW(),
    Text    varchar(256),  

    PRIMARY KEY (MessageId),

    CONSTRAINT fk_Users
      FOREIGN KEY(UserId) 
	    REFERENCES Users(UserId)
	    ON DELETE CASCADE,

    CONSTRAINT fk_Chat
      FOREIGN KEY(ChatId) 
	    REFERENCES Chat(ChatId)
	    ON DELETE CASCADE
);







