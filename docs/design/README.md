# Проєктування бази даних

В рамках проекту розробляється: 
- модель бізнес-об'єктів 
- ER-модель
- реляційна схема

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
