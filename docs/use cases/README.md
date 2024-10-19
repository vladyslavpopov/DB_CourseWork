# Модель прецедентів

## Діаграма прецедентів

<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
    
@startuml

actor "Гість" as Guest
actor "Користувач" as User
actor "Адміністратор системи" as Admin

usecase "UserRegistration\nРеєстрація користувача в системі" as UC_1.1
usecase "UserAuthorization\nАвторизація користувача" as UC_1.2

Guest -u-> UC_1.1
Guest -u-> UC_1.2

usecase "Media content management\nПошук та управління медіа-контентом" as UC_2

User -u-|> Guest
User -d-> UC_2

usecase "User management\nКерування користувачем" as UC_3

Admin -u-|> Guest
Admin -d-> UC_3

@enduml

</center>

### Схема гостя
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
    
@startuml

actor "Гість" as Guest

usecase "UserRegistration\nРеєстрація користувача в системі" as UC_1.1
usecase "UserAuthorization\nАвторизація користувача" as UC_1.2

Guest -u-> UC_1.1
Guest -u-> UC_1.2

@enduml

</center>

### Схема користувача
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml

actor "Користувач" as User

usecase "Media content management\nПошук та управління медіа-контентом" as UC_1.1

usecase "MediaFind\nПошук медіа-контенту користувачем" as UC_2.1
usecase "MediaCreate\nСтворення медіа-контенту користувачем" as UC_2.2
usecase "CommentModeration\nМодерація коментарів у соціальній мережі" as UC_2.3
usecase "EditContent\nРедагування медіа-контенту" as UC_2.4
usecase "DeleteContent\nВидалення медіа-контенту" as UC_2.5

User -d-> UC_1.1

UC_2.1 .r.> UC_1.1 : extends
UC_2.2 .u.> UC_1.1 : extends
UC_2.3 .u.> UC_1.1 : extends
UC_2.4 .u.> UC_1.1 : extends
UC_2.5 .l.> UC_1.1 : extends

@enduml

</center>

### Схема адміністратора
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>

@startuml

actor "Адміністратор" as Administrator

usecase "User management\nКерування користувачем" as UC_1.1

usecase "DeleteUser\nВидалення користувача" as UC_2.1
usecase "PromoteUser\nПідвищення ролі користувача" as UC_2.2

Administrator -d-> UC_1.1

UC_2.1 .u.> UC_1.1 : extends
UC_2.2 .u.> UC_1.1 : extends

@enduml

</center>

