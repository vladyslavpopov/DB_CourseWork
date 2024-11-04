# Проєктування бази даних

# Модель бізнес-об'єктів

```
@startuml

left to right direction

entity User <<ENTITY>> #52f752
entity User.id <<NUMBER>> #aaffaa
entity User.firstName <<TEXT>> #aaffaa
entity User.lastName <<TEXT>> #aaffaa
entity User.email <<TEXT>> #aaffaa
entity User.password <<TEXT>> #aaffaa

User.id -d-* User
User.firstName -d-* User
User.lastName -d-* User
User.email -d-* User
User.password -d-* User

entity Role <<ENTITY>> #f5a142
entity Role.id <<NUMBER>> #f5d5a3
entity Role.name <<TEXT>> #f5d5a3
entity Role.Permission <<TEXT>> #f5d5a3

Role.id -d-* Role
Role.name -d-* Role
Role.Permission -d-* Role

entity Media <<ENTITY>> #06bfbf
entity Media.id <<NUMBER>> #9effff
entity Media.title <<TEXT>> #9effff
entity Media.keywords <<TEXT>> #9effff
entity Media.createdAt <<DATE>> #9effff
entity Media.updatedAt <<DATE>> #9effff
entity Media.userId <<NUMBER>> #9effff
entity Media.type <<TEXT>> #9effff
entity Media.description <<TEXT>> #9effff

Media.id -d-* Media
Media.title -d-* Media
Media.keywords -d-* Media
Media.createdAt -d-* Media
Media.updatedAt -d-* Media
Media.userId -d-* Media
Media.type -d-* Media
Media.description -d-* Media

entity Admin <<ENTITY>> #626b70
entity DeleteAccount <<ENTITY>> #d9534f
entity DeleteAccount.id <<NUMBER>> #f7c6c7
entity DeleteAccount.userId <<NUMBER>> #f7c6c7
entity DeleteAccount.reason <<TEXT>> #f7c6c7
entity DeleteAccount.date <<DATE>> #f7c6c7

DeleteAccount.id -u-* DeleteAccount
DeleteAccount.userId -u-* DeleteAccount
DeleteAccount.reason -u-* DeleteAccount
DeleteAccount.date -u-* DeleteAccount

entity CommentModeration <<ENTITY>> #8e44ad
entity CommentModeration.commentId <<NUMBER>> #d7bde2
entity CommentModeration.userId <<NUMBER>> #d7bde2
entity CommentModeration.moderatorId <<NUMBER>> #d7bde2
entity CommentModeration.moderationReason <<TEXT>> #d7bde2
entity CommentModeration.moderationDate <<DATE>> #d7bde2
entity CommentModeration.moderationStatus <<TEXT>> #d7bde2

CommentModeration.commentId -u-* CommentModeration
CommentModeration.userId -u-* CommentModeration
CommentModeration.moderatorId -u-* CommentModeration
CommentModeration.moderationReason -u-* CommentModeration
CommentModeration.moderationDate -u-* CommentModeration
CommentModeration.moderationStatus -u-* CommentModeration

User -- Role
User -- Media
Admin -- DeleteAccount
Admin -- CommentModeration

@enduml

```

# ER-модель

@startuml
    namespace MediaManagment {
        entity Media <<ENTITY>> {
            * id : NUMBER
            * title : TEXT
            * keywords : TEXT
            * createdAt : DATE
            * updatedAt : DATE
            * userId : NUMBER
            * type : TEXT
            * description : TEXT
        }
        
        entity CommentModeration <<ENTITY>> {
            * commentId : NUMBER
            * userId : NUMBER
            * moderatorId : NUMBER
            * moderationReason : TEXT
            * moderationDate : DATE
            * moderationStatus : TEXT
        }
    
    }
    
    namespace AccountManagment {
        entity User <<ENTITY>> {
            * id : NUMBER
            * firstName : TEXT
            * lastName : TEXT
            * email : TEXT
            * password : TEXT
        }
        
        entity Admin <<ENTITY>> {
            * id : NUMBER
            * name : TEXT
        }
        
        entity DeleteAccount <<ENTITY>> {
            * id : NUMBER
            * userId : NUMBER
            * reason : TEXT
            * date : DATE
        }
    }
    
    namespace AccessPolicy {
        entity Role <<ENTITY>> {
            * id : NUMBER
            * name : TEXT
            * permission : TEXT
        }
        object UserRole 
    }
    
    User --o{ Role 
    UserRole .u.> Role
    User --> Media 
    Admin --o{ DeleteAccount 
    Admin --o{ CommentModeration 
@enduml
