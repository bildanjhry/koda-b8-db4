```mermaid
erDiagram
    USER }o--|| USER_DETAILS : Contains
    USER {
        int id PK
        string email
        string password
        date created_at
        date updated_at
    }
    USER_DETAILS {
        int id_user FK
        string name
        string address
        int status
        date created_at
        date updated_at
    }


```