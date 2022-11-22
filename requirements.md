# Mininmal requirements:

- User's platform role:
  - default
  - admin

- Default user:
  - auth
  - change own profle
  - create stream
  - delete own stream
 
- Admin:
  - auth 
  - change any user profile
  - delete any stream
  - ban any user 

- User's on stream role:
  - default
  - moderatore
  - admin(author)

- Default user:
  - watch stream
  - send message to stream chat

- Moderatore:
  - ban/unban any deafult user for chat on stream

- Moderatore:
  - add/remove moderators on stream

## DB scheme:
![alt text](https://github.com/stdtheboatman/Database/blob/main/data/database-scheme.drawio.png)


## Completed and normalized DB:
![alt text](https://github.com/stdtheboatman/Database/blob/main/data/database-scheme-norm.drawio1.png)


## DB description:

**Highlighted** fields are primary keys or part of them

- User: all users, who may use app
  - **UserId** - uuid (universal unical identifier)
  - Name - varchar(16) (an user name of the variable length)
  - RoleId - uuid (foriegn key)
  - IsBanned - boolean (if use has ban is true) 

- Log: logs for user actions
  - **LogId** - uuid (universal unical identifier)
  - UserId - uuid (foriegn key)
  - Data - varchar(128) (user action data)
  - TimeStamp - timestamp (time stamp of action)

- AuthUser: auth data for user
  - **UserId** - uuid (foriegn key)
  - PasswordHash - varchar(64) (hash of user password)

- Role: roles
  - **RoleId** - uuid (universal unical identifier)
  - RoleName - varchar(16) (role name)

- Profile: user profile
  - **UserId** - uuid (foriegn key)
  - AvatarUrl - varchar(64) (url for the profile avatar)
  - Description - varchar(256) (user profile description)

- Stream: stream data
  - **StreamId** - uuid (universal unical identifier)
  - UserId - uuid (foriegn key)
  - ChatId - uuid (foriegn key)
  - Url - varchar(64) (url for stream, where stream hosted)

- StreamViewers: many to many table between streams and users
  - **StreamId** - uuid (foriegn key)
  - **UserId** - uuid (foriegn key)

- Chat: stream chat
  - **ChatId** - uuid (universal unical identifier)
  - StreamId - uuid (foriegn key)
  - IsReadOnly - boolean (is stream read only if true)

- ChatModerators: many to many table between chats and users
  - **ChatId** - uuid (foriegn key)
  - **UserId** - uuid (foriegn key)

- ChatBannedUsers: many to many table between chats and users
  - **ChatId** - uuid (foriegn key)
  - **UserId** - uuid (foriegn key)

- Message: message for the chat
  - **MessageId** - uuid (universal unical identifier)
  - ChatId - uuid (foriegn key)
  - UserId - uuid (foriegn key)
  - TimeStamp - timestamp (time stamp of message)
  - Text - varchar(256) (message text)
