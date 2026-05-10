# Python + MySQL Integration

Integração de Python com MySQL para uso no VS Code.

## Como executar

### 1. Pré-requisitos

- Python 3.x instalado
- VS Code instalado
- MySQL Server instalado e rodando

### 2. Instalar dependências

```bash
pip install -r requirements.txt
```

Ou:
```bash
pip install mysql-connector-python
```

### 3. Configurar MySQL

#### Opção A - Manual

Crie o banco de dados e tabelas usando o arquivo schema.sql:

```bash
mysql -u root -p < schema.sql
```

Ou execute o script de setup:

```bash
./setup_mysql.sh
```

#### Opção B - Script automatizado

```bash
./setup_mysql.sh
```

Este script vai:
- Verificar se o MySQL está rodando
- Instalar as dependências Python
- Criar o banco de dados e tabelas via schema.sql
- Criar o arquivo config.py

### 4. Executar no VS Code

```bash
# No terminal do VS Code:
python3 main.py
```

Ou execute o arquivo `main.py` diretamente no VS Code (botão direito → Run Python File).

## Estrutura do Projeto

```
python-sql-integration/
├── schema.sql                 # Criação do banco e tabelas
├── database.py                # Classe DatabaseManager com operações SQL
├── main.py                    # Exemplos de uso
├── interativo.py              # Menu interativo
├── queries_avancadas.py       # Exemplos de SQL avançado
├── setup_mysql.sh             # Script de setup automatizado
├── config.py                  # Configuração de conexão (criado pelo setup)
├── config.example.py          # Exemplo de configuração
├── requirements.txt            # Dependências (mysql-connector-python)
└── README.md                  # Este arquivo
```

## Funcionalidades

- Conexão com MySQL
- Criar tabelas (via schema.sql, não no Python)
- Inserir dados (prepared statements)
- Consultar dados (todos, por ID, por curso, por nome)
- Atualizar registros
- Deletar registros
- Estatísticas (COUNT, AVG, MAX, MIN)
- Consultas avançadas (GROUP BY, HAVING, JOIN, etc.)

## Exemplos de Uso

```python
from database import DatabaseManager

# Conectar ao MySQL
db = DatabaseManager(
    host="localhost",
    user="root",
    password="sua_senha",
    database="monitoria_db"
)

# Inserir (usa %s no MySQL, não ?)
db.insert_estudante(("Nome", 20, "Curso", 8.5))

# Consultar
estudantes = db.get_all_estudantes()

# Atualizar
db.update_nota(1, 9.0)

# Deletar
db.delete_estudante(1)

db.close()
```

## Arquivo schema.sql

O arquivo `schema.sql` contém toda a estrutura do banco de dados:

```sql
CREATE DATABASE IF NOT EXISTS monitoria_db;

CREATE TABLE IF NOT EXISTS estudantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT NOT NULL,
    curso VARCHAR(100) NOT NULL,
    nota DECIMAL(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Para criar o banco de dados:

```bash
mysql -u root -p < schema.sql
```

## Diferenças SQL: SQLite vs MySQL

| SQLite | MySQL |
|--------|-------|
| `?` | `%s` |
| `INTEGER PRIMARY KEY AUTOINCREMENT` | `INT AUTO_INCREMENT PRIMARY KEY` |
| `TEXT` | `VARCHAR(100)` |
| `REAL` | `DECIMAL(3,1)` |

## Queries MySQL Suportadas

```sql
-- Básicas
SELECT * FROM estudantes
INSERT INTO estudantes (nome, idade, curso, nota) VALUES (%s, %s, %s, %s)
UPDATE estudantes SET nota = %s WHERE id = %s
DELETE FROM estudantes WHERE id = %s

-- Avançadas
SELECT curso, COUNT(*), AVG(nota) FROM estudantes GROUP BY curso
SELECT * FROM estudantes WHERE nota BETWEEN 7.0 AND 9.0
SELECT * FROM estudantes WHERE LOWER(nome) LIKE LOWER('%joão%')
SELECT * FROM estudantes ORDER BY nota DESC LIMIT 3
```

## Troubleshooting

### Erro: "Access denied for user"
- Verifique o usuário e senha do MySQL
- Certifique-se que o usuário tem permissão no banco

### Erro: "Can't connect to MySQL server"
- Verifique se o MySQL está rodando: `sudo systemctl status mysql`
- Inicie o MySQL se necessário: `sudo systemctl start mysql`

### Erro: "Unknown database"
- Crie o banco de dados: `mysql -u root -p < schema.sql`

### Erro: "Table doesn't exist"
- Execute o schema.sql para criar as tabelas
- Verifique se você está conectado no banco correto

## Notas

- Usa **prepared statements** para segurança (SQL injection)
- Charset **utf8mb4** para suporte completo de caracteres
- Engine **InnoDB** para suporte a transações
- Feche sempre a conexão com `db.close()`
- As tabelas são criadas via `schema.sql`, não no Python
