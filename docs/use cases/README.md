# Модель прецедентів

## Діаграма прецедентів

// загальна схема

### Схема гостя
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
</center>

### Схема користувача і модератора
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
    
@startuml

actor "Користувач" as User
actor "Модератор" as Moderator

usecase "UserRegistration\nРеєстрація користувача в системі" as UC_1.1
usecase "UserAuthorization\nАвторизація користувача" as UC_1.2

usecase "Media content management\nПошук та управління медіа-контентом" as UC_2.1
usecase "MediaFind\nПошук медіа-контенту користувачем" as UC_2.2
usecase "MediaCreate\nСтворення медіа-контенту користувачем" as UC_2.3
usecase "CreateComment\nСтворення коментаря" as UC_4.2

usecase "CommentModeration\nМодерація коментарів у соціальній мережі" as UC_4.1
usecase "PublishComment\nПідтвердження публікації коментаря" as UC_4.3
usecase "DeleteComment\nВидалення коментаря" as UC_4.4

User -d-> UC_1.1
User -d-> UC_1.2
User -d-> UC_2.1
User -l-> UC_4.2
User ..> UC_4.1

UC_2.2 -u-> UC_2.1: extends
UC_2.3 -u-> UC_2.1: extends

Moderator -u-|> User
Moderator ..> UC_4.1
Moderator -d-> UC_4.3
Moderator -d-> UC_4.4

@enduml

</center>

### Схема адміністратора
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
</center>
