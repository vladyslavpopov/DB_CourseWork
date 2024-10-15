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
actor "Модератор" as Moderator
actor "Журналіст" as Journalist
actor "Редактор" as Editor
actor "Адміністратор системи" as Admin

usecase "UserRegistration\nРеєстрація користувача в системі" as UC_1.1
usecase "UserAuthorization\nАвторизація користувача" as UC_1.2

usecase "Media content management\nПошук та управління медіа-контентом" as UC_2.1
usecase "MediaFind\nПошук медіа-контенту користувачем" as UC_2.2
usecase "MediaCreate\nСтворення медіа-контенту користувачем" as UC_2.3

usecase "NewsPublication\nПублікація новинного контенту на веб-сайті" as UC_3.1
usecase "CreateArticle\nСтворення статті" as UC_3.2
usecase "ReviewArticle \n Рецензування статті" as UC_3.3
usecase "PublishArticle\Підтвердження публікації статті" as UC_3.4

usecase "CommentModeration\nМодерація коментарів у соціальній мережі" as UC_4.1
usecase "CreateComment\nСтворення коментаря" as UC_4.2
usecase "PublishComment\Підтвердження публікації коментаря" as UC_4.3
usecase "DeleteComment\Видалення коментаря" as UC_4.4

Guest -u-> UC_1.1
Guest -u-> UC_1.2

User -u-|> Guest
User ..> UC_4.1
User -d-> UC_2.1
User -l-> UC_4.2

Admin ..> UC_2.1

UC_2.2 -u-> UC_2.1: extends
UC_2.3 -u-> UC_2.1: extends

Journalist -l-|> User
Journalist -u-> UC_3.2
Journalist ..> UC_3.1

Editor -d-|> User
Editor -u-> UC_3.3
Editor -u-> UC_3.4
Editor ..> UC_3.1

Moderator -u-|> User
Moderator ..> UC_4.1
Moderator -d-> UC_4.3
Moderator -d-> UC_4.4

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
#Сценарій NewsPublication


| ID               | NewsPublication |
|----------------------|-----------------|
| НАЗВА            | Публікація новинного контенту на веб-сайті |
| УЧАСНИКИ         | Журналіст, Редактор |
| ПЕРЕДУМОВИ       | Журналіст підготував новину, редактор має права на публікацію |
| РЕЗУЛЬТАТ        | Новина опублікована на веб-сайті |
| ВИКЛЮЧНІ СИТУАЦІЇ| - Журналіст не надав достатньо інформації  - Редактор не має прав на публікацію |
| ОСНОВНИЙ СЦЕНАРІЙ| 1. Журналіст готує та надсилає новину для публікації|
|                      | 2. Система перевіряє наявність всіх необхідних елементів (заголовок, текст, зображення)|
|                       | 3. Редактор отримує новину для перегляду |
|                       |4. Редактор вносить правки або підтверджує публікацію|
|                       |5. Система публікує новину на веб-сайті|
|                       |6. Система повідомляє редактора та журналіста про успішну публікацію новини. |



@startuml

|Журналіст|
start;
: Готує новину та надсилає її редактору;

|Редактор|
: Отримує новину для перегляду;
: Перевіряє наявність всіх необхідних елементів (заголовок, текст, зображення);
note right #FF6969
<b> Можлива виключна ситуація
<b> NotEnoughInformation
end note
: Вносить правки або підтверджує публікацію;
note right #FF6969
<b> Можлива виключна ситуація
<b> NoPublishingRights
end note

: Публікує новину на веб-сайті;
: Повідомляє журналіста про успішну публікацію;

stop;
@enduml

# Сценарій CommentModeration

   | ID               | CommentModeration |
|----------------------|-----------------|
| НАЗВА            | Модерація коментарів у соціальній мережі |
| УЧАСНИКИ         | Модератор, Користувач|
| ПЕРЕДУМОВИ       | Користувач залишив коментар, модератор має права на модерацію |
| РЕЗУЛЬТАТ        |Коментар опубліковано або видалено залежно від рішення модератора |
| ВИКЛЮЧНІ СИТУАЦІЇ| 1. Користувач залишив недопустимий коментар |
|                      | 2 Коментар вже видалено |
| ОСНОВНИЙ СЦЕНАРІЙ| 1. Модератор переглядає нові коментарі в системі|
|                      | 2.  Система перевіряє наявність недопустимого контенту|
|                      |3. Модератор вибирає коментар для перегляду |
|                      |4. Система надає опції для публікації або видалення коментаря|
|                      |5. Модератор приймає рішення про публікацію або видалення|
|                      |6.Система повідомляє користувача про результат (коментар опубліковано або видалено) |

@startuml

|Модератор|
start;
: Переглядає нові коментарі;

|Користувач|
: Залишає коментар;

|Модератор|
: Вибирає коментар для перегляду;
: Перевіряє наявність недопустимого контенту;
note right #FF6969
<b> Можлива виключна ситуація
<b> CommentAlreadyDeleted
end note

: Приймає рішення про публікацію або видалення;
note right #FF6969
<b> Можлива виключна ситуація
<b> InappropriateComment
end note

: Публікує або видаляє коментар;

|Користувач|
: Отримує повідомлення про результат модерації (коментар опубліковано або видалено);

stop;
@enduml

### Схема користувача, модератора і адміністратора
<center style="
    border-radius:4px;
    border: 1px solid #cfd7e6;
    box-shadow: 0 1px 3px 0 rgba(89,105,129,.05), 0 1px 1px 0 rgba(0,0,0,.025);
    padding: 1em;"
>
    
@startuml

actor "Користувач" as User
actor "Модератор" as Moderator
actor "Адміністратор системи" as Admin

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

Admin ..> UC_2.1

@enduml

</center>
